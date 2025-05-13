using System.Linq;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.Character
{
    public class FullBodyVariant
    {
        public FullBodyElement[] Elements { get; }
        public GameObject PreviewObject { get; }
        public string Name => Elements.First().Mesh.name;

        public FullBodyVariant(FullBodyEntry fullBodyEntry)
        {
            Elements = fullBodyEntry.Slots.Select(s => new FullBodyElement(s.Type, s.GameObject.GetComponentInChildren<SkinnedMeshRenderer>().sharedMesh)).ToArray();
            PreviewObject = PreviewCreator.CreateVariantPreview(GetPreviewMesh(Elements));
        }

        private static Mesh GetPreviewMesh(FullBodyElement[] elements)
        {
            var element = elements.FirstOrDefault(e => e.Type == SlotType.Hat)
                          ?? elements.FirstOrDefault(e => e.Type == SlotType.Outerwear)
                          ?? elements.First();

            return element.Mesh;
        }
    }

    public class FullBodyElement
    {
        public SlotType Type { get; }
        public Mesh Mesh { get; }

        public FullBodyElement(SlotType type, Mesh mesh)
        {
            Type = type;
            Mesh = mesh;
        }
    }
}