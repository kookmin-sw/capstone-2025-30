using UnityEditor;

namespace CharacterCustomizationTool.Editor.Character
{
    public static class SlotLibraryLoader
    {
        public static SlotLibrary LoadSlotLibrary()
        {
            return AssetDatabase.LoadAssetAtPath<SlotLibrary>(AssetsPath.SlotLibrary);
        }
    }
}