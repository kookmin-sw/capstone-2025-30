using System.Linq;

namespace CharacterCustomizationTool.Editor.MaterialManagement
{
    public static class MaterialPaths
    {
        private static readonly string[] MainColorNames = { "Material", "Color" };
        private static readonly string GlassName = "Glass";
        private static readonly string EmissionName = "Emission";

        public static readonly string[] MainColorPaths = MainColorNames.Select(GetMaterialPath).ToArray();
        public static readonly string GlassPath = GetMaterialPath(GlassName);
        public static readonly string EmissionPath = GetMaterialPath(EmissionName);

        private static string GetMaterialPath(string materialName)
        {
            return $"{AssetsPath.Folder.Materials}{materialName}.mat";
        }
    }
}