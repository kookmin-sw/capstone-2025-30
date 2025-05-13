using UnityEngine;

namespace CharacterCustomizationTool.Editor.Character
{
    public class SlotVariant
    {
        public Mesh Mesh { get; }
        public GameObject PreviewObject { get; }
        public string Name => Mesh.name;

        public SlotVariant(Mesh mesh)
        {
            Mesh = mesh;
            PreviewObject = PreviewCreator.CreateVariantPreview(mesh);
        }
    }
}