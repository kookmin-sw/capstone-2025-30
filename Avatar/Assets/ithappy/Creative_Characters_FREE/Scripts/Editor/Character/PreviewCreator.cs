using CharacterCustomizationTool.Editor.MaterialManagement;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.Character
{
    public static class PreviewCreator
    {
        private static readonly MaterialProvider MaterialProvider = new();

        public static GameObject CreateVariantPreview(Mesh mesh)
        {
            var variant = new GameObject(mesh.name);

            variant.AddComponent<MeshFilter>().sharedMesh = mesh;
            variant.transform.position = Vector3.one * int.MaxValue;
            variant.hideFlags = HideFlags.HideAndDontSave;

            var renderer = variant.AddComponent<MeshRenderer>();
            renderer.sharedMaterial = MaterialProvider.MainColor;

            return variant;
        }
    }
}