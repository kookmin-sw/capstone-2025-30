using System;
using UnityEditor;
using UnityEngine;

namespace CharacterCustomizationTool.Editor
{
    public class LayerMaskUtility
    {
        public static void CreateLayer(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                throw new ArgumentNullException(nameof(name), "New layer name string is either null or empty.");
            }

            var tagManager = new SerializedObject(AssetDatabase.LoadAllAssetsAtPath("ProjectSettings/TagManager.asset")[0]);
            var layerProps = tagManager.FindProperty("layers");
            var propCount = layerProps.arraySize;

            SerializedProperty firstEmptyProp = null;

            for (var i = 0; i < propCount; i++)
            {
                var layerProp = layerProps.GetArrayElementAtIndex(i);
                var stringValue = layerProp.stringValue;
                if (stringValue == name)
                {
                    return;
                }

                if (i < 8 || stringValue != string.Empty)
                {
                    continue;
                }

                firstEmptyProp ??= layerProp;
            }

            if (firstEmptyProp == null)
            {
                Debug.LogError("Maximum limit of " + propCount + " layers exceeded. Layer \"" + name + "\" not created.");

                return;
            }

            firstEmptyProp.stringValue = name;
            tagManager.ApplyModifiedProperties();
        }
    }
}