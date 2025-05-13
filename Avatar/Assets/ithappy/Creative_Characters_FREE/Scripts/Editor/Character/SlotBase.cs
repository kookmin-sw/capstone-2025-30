using UnityEngine;

namespace CharacterCustomizationTool.Editor.Character
{
    public abstract class SlotBase
    {
        public abstract string Name { get; }
        public abstract GameObject Preview { get; }
        public abstract int SelectedIndex { get; }
        public abstract int VariantsCount { get; }
        public abstract (SlotType, Mesh)[] Meshes { get; }

        public SlotType Type { get; }
        public bool IsEnabled { get; private set; } = true;

        protected SlotBase(SlotType type)
        {
            Type = type;
        }

        public abstract void SelectNext();
        public abstract void SelectPrevious();
        public abstract void Select(int index);
        public abstract bool TryGetVariantsCountInGroup(GroupType groupType, out int count);
        public abstract bool TryPickInGroup(GroupType groupType, int index, bool isEnabled);

        public void Draw(Material material, int previewLayer, Camera camera, int submeshIndex)
        {
            if (IsEnabled)
            {
                DrawSlot(material, previewLayer, camera, submeshIndex);
            }
        }

        public bool IsOfType(SlotType type)
        {
            return Type == type;
        }

        public void Toggle(bool isToggled)
        {
            IsEnabled = isToggled;
        }

        protected abstract void DrawSlot(Material material, int previewLayer, Camera camera, int submeshIndex);

        protected int GetNextIndex()
        {
            var targetIndex = SelectedIndex + 1;
            if (targetIndex >= VariantsCount)
            {
                targetIndex = 0;
            }

            return targetIndex;
        }

        protected int GetPreviousIndex()
        {
            var targetIndex = SelectedIndex - 1;
            if (targetIndex < 0)
            {
                targetIndex = VariantsCount - 1;
            }
            return targetIndex;
        }

        protected static void DrawMesh(Mesh mesh, Material material, int previewLayer, Camera camera, int submeshIndex)
        {
            Graphics.DrawMesh(mesh, new Vector3(0, -.01f, 0), Quaternion.identity, material, previewLayer, camera, submeshIndex);
        }
    }
}