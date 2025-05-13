using System;
using System.Linq;
using CharacterCustomizationTool.FaceManagement;
using UnityEditor;

namespace CharacterCustomizationTool.Editor.FaceEditor
{
    [CustomEditor(typeof(FacePicker))]
    public class FacePickerEditor : UnityEditor.Editor
    {
        public override void OnInspectorGUI()
        {
            base.OnInspectorGUI();

            var facePicker = (FacePicker)target;

            var previousFace = facePicker.ActiveFace;

            var availableFaces =
                Enum.GetValues(typeof(FaceType))
                    .Cast<FaceType>()
                    .Where(facePicker.HasFace)
                    .ToArray();

            var activeFaceIndex = Array.IndexOf(availableFaces, facePicker.ActiveFace);

            var newFaceIndex = EditorGUILayout.Popup("Face", activeFaceIndex, availableFaces.Select(f => f.ToString()).ToArray());
            var newFace = availableFaces[newFaceIndex];

            if (newFace != previousFace)
            {
                facePicker.PickFace(newFace);

                EditorUtility.SetDirty(facePicker.gameObject);
                AssetDatabase.SaveAssetIfDirty(facePicker.gameObject);
            }
        }
    }
}