using System.Linq;
using CharacterCustomizationTool.Extensions;

namespace CharacterCustomizationTool.Editor
{
    public class SlotName
    {
        private readonly string[] _nameSections;

        public SlotName(string name)
        {
            _nameSections = SplitName(name);
        }

        public override string ToString()
        {
            return _nameSections.Aggregate((p, c) => p + c.ToCapital());
        }

        private static string[] SplitName(string name)
        {
            var nameParts = name.Split('_', '-');

            return nameParts;
        }
    }
}