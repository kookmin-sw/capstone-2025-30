using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace CharacterCustomizationTool.Editor
{
    public static class AssetLoader
    {
        public static IEnumerable<T> LoadAssets<T>(string filter, string folder)
            where T : Object
        {
            var assets = AssetDatabase.FindAssets(filter, new[] { folder })
                .Select(AssetDatabase.GUIDToAssetPath)
                .Select(AssetDatabase.LoadAssetAtPath<T>)
                .ToArray();

            return assets;
        }
    }
}