namespace CharacterCustomizationTool.Editor.Randomizer.Steps
{
    public interface IRandomizerStep
    {
        GroupType GroupType { get; }

        StepResult Process(int count, GroupType[] groups);
    }
}