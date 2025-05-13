using System.Collections.Generic;
using System.Linq;
using CharacterCustomizationTool.FaceManagement;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.FaceEditor
{
    public static class FaceLoader
    {
        public static void AddFaces(GameObject gameObject)
        {
            var faceMeshes = AssetLoader.LoadAssets<Mesh>("t:Mesh", AssetsPath.Folder.Faces).ToArray();
            var maleFace = FilterBy("Male", faceMeshes);
            var femaleFace = FilterBy("Female", faceMeshes);

            var groupedMaleFaces = Group(maleFace);
            var groupedFemaleFaces = Group(femaleFace);

            var skinnedMeshRenderer = gameObject.transform
                .Cast<Transform>()
                .First(t => t.name.StartsWith("Face"))
                .GetComponent<SkinnedMeshRenderer>();

            if (skinnedMeshRenderer.sharedMesh)
            {
                var facePicker = gameObject.AddComponent<FacePicker>();

                var nameSections = skinnedMeshRenderer.sharedMesh.name.Split("_");
                var groupedFaces = nameSections.First() == "Male" ? groupedMaleFaces : groupedFemaleFaces;
                var faces = ChooseFaces(skinnedMeshRenderer.sharedMesh.name, groupedFaces);

                facePicker.SetFaces(faces);
            }
        }

        private static Mesh[] ChooseFaces(string faceName, Dictionary<string, Mesh[]> groupedFaces)
        {
            var faceKey = faceName.Split("_")[3];
            var faces = groupedFaces[faceKey];

            return faces;
        }

        private static IEnumerable<Mesh> FilterBy(string keyword, IEnumerable<Mesh> meshes)
        {
            return meshes.Where(m => m.name.StartsWith(keyword)).ToArray();
        }

        private static Dictionary<string, Mesh[]> Group(IEnumerable<Mesh> meshes)
        {
            var groupedMeshes = meshes
                .GroupBy(m => m.name.Split("_")[3])
                .ToDictionary(g => g.Key, g => g.ToArray());

            return groupedMeshes;
        }
    }
}