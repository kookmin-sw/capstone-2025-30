using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.Character
{
    public class FullBodySlot : SlotBase
    {
        private readonly List<FullBodyVariant> _variants;

        private FullBodyVariant _selected;

        public override string Name => "Full Body";
        public override GameObject Preview => _selected.PreviewObject;
        public override int SelectedIndex => _variants.FindIndex(v => v.Name == _selected.Name);
        public override int VariantsCount => _variants.Count;
        public override (SlotType, Mesh)[] Meshes => _selected.Elements.Select(e => (e.Type, e.Mesh)).ToArray();

        public FullBodySlot(FullBodyEntry[] fullBodyEntries) : base(SlotType.FullBody)
        {
            _variants = fullBodyEntries.Select(e => new FullBodyVariant(e)).ToList();
            _selected = _variants.First();
        }

        public override void SelectNext()
        {
            _selected = _variants[GetNextIndex()];
        }

        public override void SelectPrevious()
        {
            _selected = _variants[GetPreviousIndex()];
        }

        public override void Select(int index)
        {
            _selected = _variants[index];
        }

        public override bool TryGetVariantsCountInGroup(GroupType groupType, out int count)
        {
            if (groupType == GroupType.Costumes)
            {
                count = _variants.Count;
                return true;
            }

            count = 0;
            return false;
        }

        public override bool TryPickInGroup(GroupType groupType, int index, bool isEnabled)
        {
            if (!isEnabled || groupType != GroupType.Costumes)
            {
                return false;
            }

            _selected = _variants[index];
            Toggle(true);

            return true;
        }

        protected override void DrawSlot(Material material, int previewLayer, Camera camera, int submeshIndex)
        {
            foreach (var element in _selected.Elements)
            {
                DrawMesh(element.Mesh, material, previewLayer, camera, submeshIndex);
            }
        }
    }
}