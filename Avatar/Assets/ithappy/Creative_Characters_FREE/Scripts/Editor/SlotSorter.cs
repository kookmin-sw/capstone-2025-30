using System.Collections.Generic;
using System.Linq;
using CharacterCustomizationTool.Editor.Character;

namespace CharacterCustomizationTool.Editor
{
    public static class SlotSorter
    {
        private static readonly List<SlotType> SlotTypesInOrder = new()
        {
            SlotType.Body,
            SlotType.Faces,
            SlotType.FullBody,
            SlotType.Hat,
            SlotType.Hairstyle,
            SlotType.Mustache,
            SlotType.Glasses,
            SlotType.Accessories,
            SlotType.Outerwear,
            SlotType.TShirt,
            SlotType.Gloves,
            SlotType.Pants,
            SlotType.Shoes,
        };

        public static IEnumerable<SlotBase> Sort(IEnumerable<SlotBase> slots)
        {
            var sortedSlots = SlotTypesInOrder
                .Select(type => slots.FirstOrDefault(p => p.IsOfType(type)))
                .Where(part => part != null)
                .ToList();

            return sortedSlots;
        }
    }
}