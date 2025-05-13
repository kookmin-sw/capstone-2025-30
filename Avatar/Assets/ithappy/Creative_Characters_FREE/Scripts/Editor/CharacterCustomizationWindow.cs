using System.IO;
using System.Linq;
using CharacterCustomizationTool.Editor.Character;
using CharacterCustomizationTool.Editor.FaceEditor;
using CharacterCustomizationTool.Editor.MaterialManagement;
using Controller;
using UnityEditor;
using UnityEditor.Animations;
using UnityEngine;

namespace CharacterCustomizationTool.Editor
{
    public class CharacterCustomizationWindow : EditorWindow
    {
        private const string PreviewLayerName = "Character Preview";

        private CustomizableCharacter _customizableCharacter;
        private PartsEditor _partsEditor;
        private Camera _camera;
        private int _previewLayer;
        private RenderTexture _renderTexture;
        private string _prefabPath;

        [MenuItem("Tools/Character Customization")]
        private static void Init()
        {
            FindRoot();
            var window = GetWindow<CharacterCustomizationWindow>("Character Customization");
            window.minSize = new Vector2(990, 655);
            window.Show();
        }

        private void OnEnable()
        {
            _customizableCharacter = new CustomizableCharacter(SlotLibraryLoader.LoadSlotLibrary());
            _partsEditor = new PartsEditor();

            LayerMaskUtility.CreateLayer(PreviewLayerName);
            _previewLayer = LayerMask.NameToLayer(PreviewLayerName);
        }

        private void OnGUI()
        {
            var rect = new Rect(10, 10, 300, 300);

            CreateRenderTexture();
            InitializeCamera();
            DrawCharacter();
            _partsEditor.OnGUI(new Rect(330, 10, position.width - 330, position.height), _customizableCharacter);

            GUI.DrawTexture(rect, _renderTexture, ScaleMode.StretchToFill, false);

            GUI.Label(new Rect(10, 320, 100, 25), "Prefab folder:");
            GUI.Label(new Rect(10, 345, 350, 25), AssetsPath.SavedCharacters);
            _prefabPath = GUI.TextField(new Rect(10, 372, 300, 20), _prefabPath);

            var saveButtonRect = new Rect(10, 400, 300, 40);
            if (GUI.Button(saveButtonRect, "Save Prefab"))
            {
                SavePrefab();
            }

            var randomizeButtonRect = new Rect(85, 450, 150, 30);
            if (GUI.Button(randomizeButtonRect, "Randomize"))
            {
                Randomize();
            }

            var isZero = _customizableCharacter.SavedCombinationsCount == 0;
            var isSame = false;
            var lessThenTwo = false;

            if (!isZero)
            {
                isSame = _customizableCharacter.IsSame();
                lessThenTwo = _customizableCharacter.SavedCombinationsCount < 2;
            }

            using (new EditorGUI.DisabledScope(isZero || (isSame && lessThenTwo)))
            {
                var lastButtonRect = new Rect(240, 450, 50, 30);
                if (GUI.Button(lastButtonRect, "Last"))
                {
                    _customizableCharacter.LastCombination();
                }
            }
        }

        private void SavePrefab()
        {
            var character = _customizableCharacter.InstantiateCharacter();
            var materialProvider = new MaterialProvider();

            var enabledSlots = _customizableCharacter.Slots.Where(s => s.IsEnabled).ToArray();

            foreach (var slot in enabledSlots)
            {
                foreach (var mesh in slot.Meshes)
                {
                    var child = character.transform.Cast<Transform>().First(t => t.name.StartsWith(mesh.Item1.ToString()));
                    if (child.TryGetComponent<SkinnedMeshRenderer>(out var skinnedMeshRenderer))
                    {
                        skinnedMeshRenderer.sharedMesh = mesh.Item2;
                        skinnedMeshRenderer.sharedMaterial = materialProvider.MainColor;
                        skinnedMeshRenderer.localBounds = skinnedMeshRenderer.sharedMesh.bounds;
                    }
                }
            }

            FaceLoader.AddFaces(character);
            AddAnimator(character);
            AddMovementComponents(character);

            var prefabPath = AssetsPath.SavedCharacters + _prefabPath;
            Directory.CreateDirectory(prefabPath);
            var path = AssetDatabase.GenerateUniqueAssetPath($"{prefabPath}/Character.prefab");
            PrefabUtility.SaveAsPrefabAsset(character, path);
            DestroyImmediate(character);
        }

        private static void AddAnimator(GameObject character)
        {
            var controller = AssetDatabase.LoadAssetAtPath<AnimatorController>(AssetsPath.AnimationController);
            var animator = character.GetComponent<Animator>();
            animator.runtimeAnimatorController = controller;
            animator.applyRootMotion = false;
        }

        private static void AddMovementComponents(GameObject character)
        {
            AddCharacterController(character);
            character.AddComponent<CharacterMover>();
            character.AddComponent<MovePlayerInput>();
        }

        private static void AddCharacterController(GameObject character)
        {
            var characterController = character.AddComponent<CharacterController>();

            characterController.center = new Vector3(0, .95f, 0);
            characterController.radius = .4f;
            characterController.height = 1.8f;
        }

        private void Randomize()
        {
            _customizableCharacter.Randomize();
            _customizableCharacter.SaveCombination();
        }

        private void InitializeCamera()
        {
            if (_camera)
            {
                return;
            }

            var cameraPivot = new GameObject("CameraPivot").transform;
            cameraPivot.gameObject.hideFlags = HideFlags.HideAndDontSave;

            var cameraObject = new GameObject("PreviewCamera")
            {
                hideFlags = HideFlags.HideAndDontSave
            };

            _camera = cameraObject.AddComponent<Camera>();
            _camera.targetTexture = _renderTexture;
            _camera.clearFlags = CameraClearFlags.SolidColor;
            _camera.renderingPath = RenderingPath.Forward;
            _camera.enabled = false;
            _camera.useOcclusionCulling = false;
            _camera.cameraType = CameraType.Preview;
            _camera.fieldOfView = 4.5f;
            _camera.clearFlags = CameraClearFlags.SolidColor;
            _camera.transform.SetParent(cameraPivot);
            _camera.cullingMask = 1 << _previewLayer;

            cameraPivot.Rotate(Vector3.up, 150, Space.Self);
        }

        private void CreateRenderTexture()
        {
            if (_renderTexture)
            {
                return;
            }

            _renderTexture = new RenderTexture(300, 300, 30, RenderTextureFormat.ARGB32)
            {
                antiAliasing = 8
            };
        }

        private void DrawCharacter()
        {
            _camera.transform.localPosition = new Vector3(0, 1.1f, -36);
            _customizableCharacter.Draw(_previewLayer, _camera);
            _camera.Render();
        }

        private static void FindRoot()
        {
            var anchorAssetGuid = string.Empty;

            foreach (var keyword in AssetsPath.BaseMesh.Keywords)
            {
                var assetGuids = AssetDatabase.FindAssets(keyword);

                foreach (var guid in assetGuids)
                {
                    if (AssetDatabase.GUIDToAssetPath(guid).Contains("Meshes"))
                    {
                        anchorAssetGuid = guid;
                        break;
                    }
                }

                if (!string.IsNullOrEmpty(anchorAssetGuid))
                {
                    break;
                }
            }

            var anchorAssetPath = AssetDatabase.GUIDToAssetPath(anchorAssetGuid);
            var pathParts = anchorAssetPath.Split('/');
            var packTitleParts = AssetsPath.PackageName.Split('_');
            var rootFound = false;
            for (var i = pathParts.Length - 1; i >= 0; i--)
            {
                if (rootFound)
                {
                    break;
                }

                foreach (var part in packTitleParts)
                {
                    rootFound = false;

                    if (!pathParts[i].Contains(part))
                    {
                        pathParts[i] = string.Empty;
                        break;
                    }

                    rootFound = true;
                }
            }

            var root = string.Join("/", pathParts.Where(p => !string.IsNullOrEmpty(p)).ToArray()) + "/";
            AssetsPath.SetRoot(root);
        }
    }
}