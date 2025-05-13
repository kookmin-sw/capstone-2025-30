using System.Collections.Generic;
using System.Linq;
using CharacterCustomizationTool.Editor.MaterialManagement;
using CharacterCustomizationTool.Editor.Randomizer;
using CharacterCustomizationTool.Editor.SlotValidation;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.Character
{
    public class CustomizableCharacter
    {
        private static readonly SlotType[] AlwaysEnabledParts = { SlotType.Body, SlotType.Faces };

        private readonly List<List<SavedSlot>> _savedCombinations = new();
        private readonly GameObject _characterGameObject;
        private readonly SlotValidator _slotValidator = new();

        public SlotBase[] Slots { get; }
        public int SavedCombinationsCount => _savedCombinations.Count;

        public CustomizableCharacter(SlotLibrary slotLibrary)
        {
            _characterGameObject = LoadBaseMesh();
            Slots = CreateSlots(slotLibrary);
        }

        public GameObject InstantiateCharacter()
        {
            var character = Object.Instantiate(_characterGameObject, Vector3.zero, Quaternion.identity);

            return character;
        }

        public void SelectPrevious(SlotType slotType)
        {
            GetSlotBy(slotType).SelectPrevious();
        }

        public void SelectNext(SlotType slotType)
        {
            GetSlotBy(slotType).SelectNext();
        }

        public bool IsToggled(SlotType slotType)
        {
            return GetSlotBy(slotType).IsEnabled;
        }

        public void Toggle(SlotType type, bool isToggled)
        {
            GetSlotBy(type).Toggle(isToggled);
            _slotValidator.Validate(this, type, isToggled);
        }

        public void Draw(int previewLayer, Camera camera)
        {
            var materialProvider = new MaterialProvider();

            foreach (var slot in Slots)
            {
                slot.Draw(materialProvider.MainColor, previewLayer, camera, 0);
            }
        }

        public void Randomize()
        {
            var randomCharacterGenerator = new RandomCharacterGenerator();
            randomCharacterGenerator.Randomize(this);
        }

        public void SaveCombination()
        {
            var savedCombinations = Slots.Select(slot => new SavedSlot(slot.Type, slot.IsEnabled, slot.SelectedIndex)).ToList();
            _savedCombinations.Add(savedCombinations);

            while (_savedCombinations.Count > 4)
            {
                _savedCombinations.RemoveAt(0);
            }
        }

        public void LastCombination()
        {
            var lastSavedCombination = _savedCombinations.Last();
            if (IsSame())
            {
                _savedCombinations.Remove(lastSavedCombination);
                lastSavedCombination = _savedCombinations.Last();
            }

            foreach (var slot in Slots)
            {
                var savedCombination = lastSavedCombination.Find(c => c.SlotType == slot.Type);

                slot.Toggle(savedCombination.IsEnabled);
                slot.Select(savedCombination.VariantIndex);
            }

            _savedCombinations.Remove(lastSavedCombination);
        }

        public bool IsSame()
        {
            var lastSavedCombination = _savedCombinations.Last();

            return !Slots
                .Select(slot => new { slot, savedCombination = lastSavedCombination.Find(c => c.SlotType == slot.Type) })
                .Where(t => t.slot.IsEnabled != t.savedCombination.IsEnabled || t.slot.SelectedIndex != t.savedCombination.VariantIndex)
                .Select(t => t.slot)
                .Any();
        }

        public void PickGroup(GroupType groupType, int index, bool isEnabled)
        {
            foreach (var slot in Slots)
            {
                if (slot.TryPickInGroup(groupType, index, isEnabled))
                {
                    break;
                }
            }
        }

        public int GetVariantsCountInGroup(GroupType groupType)
        {
            foreach (var slot in Slots)
            {
                if (slot.TryGetVariantsCountInGroup(groupType, out var count))
                {
                    return count;
                }
            }

            return 0;
        }

        public void ToDefault()
        {
            foreach (var slot in Slots)
            {
                if (slot.Type != SlotType.Body && slot.Type != SlotType.Faces)
                {
                    slot.Toggle(false);
                }
            }
        }

        public List<SlotName> GetSlotNames()
        {
            var partNames = _characterGameObject.transform
                .Cast<Transform>()
                .Where(mesh => mesh.TryGetComponent<Renderer>(out _))
                .Select(mesh => new SlotName(mesh.name)).ToList();

            return partNames;
        }

        public static bool IsAlwaysEnabled(SlotType slotType)
        {
            return AlwaysEnabledParts.Contains(slotType);
        }

        private SlotBase GetSlotBy(SlotType slotType)
        {
            return Slots.FirstOrDefault(s => s.Type == slotType);
        }

        private static GameObject LoadBaseMesh()
        {
            var availableBaseMeshes = new List<GameObject>();

            foreach (var keyword in AssetsPath.BaseMesh.Keywords)
            {
                var baseMeshes = AssetLoader.LoadAssets<GameObject>(keyword, AssetsPath.BaseMesh.Path);
                availableBaseMeshes.AddRange(baseMeshes);
            }

            var baseMesh = availableBaseMeshes.First();

            return baseMesh;
        }

        private static SlotBase[] CreateSlots(SlotLibrary slotLibrary)
        {
            var list = new List<SlotBase>();
            list.Add(new FullBodySlot(slotLibrary.FullBodyCostumes));
            list.AddRange(slotLibrary.Slots.Select(s => new Slot(s.Type, s.Groups)));

            var sortedSlots = SlotSorter.Sort(list);

            return sortedSlots.ToArray();
        }
    }
}