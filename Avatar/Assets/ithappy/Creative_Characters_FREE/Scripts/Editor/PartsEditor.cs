using CharacterCustomizationTool.Editor.Character;
using UnityEditor;
using UnityEngine;

namespace CharacterCustomizationTool.Editor
{
    public class PartsEditor
    {
        private const float Width = 150;

        private Vector2 _scrollPosition;

        public void OnGUI(Rect rect, CustomizableCharacter character)
        {
            var slots = character.Slots;
            using (new GUI.GroupScope(rect))
            {
                using (var scrollViewScope = new GUILayout.ScrollViewScope(_scrollPosition))
                {
                    _scrollPosition = scrollViewScope.scrollPosition;
                    using (new GUILayout.HorizontalScope())
                    {
                        const int step = 3;
                        var index = 0;
                        while (index < slots.Length)
                        {
                            using (new GUILayout.VerticalScope(GUILayout.Width(100)))
                            {
                                for (var i = index; i < index + step; i++)
                                {
                                    if (i < slots.Length)
                                    {
                                        RenderPart(character, slots[i]);
                                    }
                                }
                            }
                            index += step;
                        }
                    }
                }
            }
        }

        private static void RenderPart(CustomizableCharacter character, SlotBase slot)
        {
            using (new GUILayout.VerticalScope(EditorStyles.helpBox, GUILayout.Width(Width)))
            {
                GUILayout.Label(slot.Name);
                GUILayout.Box(AssetPreview.GetAssetPreview(slot.Preview));
                if (CustomizableCharacter.IsAlwaysEnabled(slot.Type))
                {
                    using (new EditorGUI.DisabledScope(true))
                    {
                        RenderToggle(character, slot.Type);
                    }
                }
                else if (slot.Type == SlotType.FullBody)
                {
                    RenderToggle(character, slot.Type);
                }
                else
                {
                    using (new EditorGUI.DisabledScope(false))
                    {
                        RenderToggle(character, slot.Type);
                    }
                }

                using (new EditorGUI.DisabledScope(!slot.IsEnabled))
                {
                    using (new GUILayout.HorizontalScope(EditorStyles.helpBox, GUILayout.Width(Width)))
                    {
                        RenderLeftButton(character, slot.Type);
                        RenderCounter(slot);
                        RenderRightButton(character, slot.Type);
                    }
                }
            }
        }

        private static void RenderToggle(CustomizableCharacter character, SlotType type)
        {
            var isToggled = EditorGUILayout.ToggleLeft("Enabled", character.IsToggled(type), GUILayout.Width(100));
            character.Toggle(type, isToggled);
        }

        private static void RenderLeftButton(CustomizableCharacter character, SlotType slotType)
        {
            if (GUILayout.Button("<"))
            {
                character.SelectPrevious(slotType);
            }
        }

        private static void RenderRightButton(CustomizableCharacter character, SlotType slotType)
        {
            if (GUILayout.Button(">"))
            {
                character.SelectNext(slotType);
            }
        }

        private static void RenderCounter(SlotBase slot)
        {
            var style = new GUIStyle
            {
                alignment = TextAnchor.MiddleCenter,
                normal =
                {
                    textColor = Color.white
                },
                fixedWidth = 70,
            };

            GUILayout.Label($"{slot.SelectedIndex + 1}/{slot.VariantsCount}", style);
        }
    }
}