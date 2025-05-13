namespace CharacterCustomizationTool.Editor.Randomizer
{
    public class StepResult
    {
        public int Index { get; }
        public bool IsActive { get; }
        public GroupType[] AvailableGroups { get; }

        public StepResult(int index, bool isActive, GroupType[] availableGroups)
        {
            Index = index;
            IsActive = isActive;
            AvailableGroups = availableGroups;
        }
    }
}