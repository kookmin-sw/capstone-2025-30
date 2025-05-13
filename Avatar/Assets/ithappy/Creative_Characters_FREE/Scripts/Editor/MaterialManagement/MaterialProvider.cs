using UnityEngine;

namespace CharacterCustomizationTool.Editor.MaterialManagement
{
    public class MaterialProvider
    {
        private readonly MaterialOnDemand _mainColor = new(MaterialPaths.MainColorPaths);
        private readonly MaterialOnDemand _glass = new(MaterialPaths.GlassPath);
        private readonly MaterialOnDemand _emission = new(MaterialPaths.EmissionPath);

        public Material MainColor => _mainColor.Value;
        public Material Glass => _glass.Value;
        public Material Emission => _emission.Value;
    }
}