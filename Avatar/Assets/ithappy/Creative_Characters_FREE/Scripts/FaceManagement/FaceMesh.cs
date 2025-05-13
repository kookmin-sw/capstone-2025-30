using System;
using CharacterCustomizationTool.Extensions;
using UnityEngine;

namespace CharacterCustomizationTool.FaceManagement
{
    [Serializable]
    public class FaceMesh
    {
        public FaceType Type;
        public Mesh Mesh;

        public FaceMesh(Mesh mesh)
        {
            Type = Enum.Parse<FaceType>(mesh.name.Split("_")[2].ToCapital());
            Mesh = mesh;
        }
    }
}