namespace CharacterCustomizationTool.Editor
{
    public static class AssetsPath
    {
        public const string PackageName = "Creative_Characters_FREE";

        public static string AnimationController => _root + "Animations/Animation_Controllers/Character_Movement.controller";
        public static string SavedCharacters => _root + "Saved_Characters/";
        public static string SlotLibrary => _root + "Configs/SlotLibrary.asset";

        private static string _root = "Assets/ithappy/" + PackageName + "/";

        public static void SetRoot(string root)
        {
            _root = root;
        }

        public static class BaseMesh
        {
            public static readonly string[] Keywords =
            {
                "Base",
                "Basic"
            };

            public static string Path => _root + "Meshes/";
        }

        public static class Folder
        {
            public static string Materials => _root + "Materials/";
            public static string Meshes => _root + "Meshes";
            public static string Faces => _root + "Meshes/Faces/";
        }
    }
}