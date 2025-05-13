using System;
using UnityEditor;
using UnityEngine;

namespace CharacterCustomizationTool.Editor.MaterialManagement
{
    public class MaterialOnDemand
    {
        private readonly string[] _paths;

        private Material _value;

        public Material Value => _value ? _value : LoadMaterial();

        public MaterialOnDemand(params string[] paths)
        {
            _paths = paths;
        }

        private Material LoadMaterial()
        {
            foreach (var path in _paths)
            {
                var loadedMaterial = AssetDatabase.LoadAssetAtPath<Material>(path);

                if (loadedMaterial != null)
                {
                    return loadedMaterial;
                }
            }

            throw new Exception();
        }
    }
}