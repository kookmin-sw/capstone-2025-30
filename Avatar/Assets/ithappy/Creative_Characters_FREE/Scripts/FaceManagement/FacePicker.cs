using System;
using System.Linq;
using CharacterCustomizationTool.Extensions;
using UnityEngine;

namespace CharacterCustomizationTool.FaceManagement
{
    public class FacePicker : MonoBehaviour
    {
        [SerializeField, HideInInspector]
        private FaceMesh[] _faceMeshes;

        private SkinnedMeshRenderer _faceRenderer;

        public FaceType ActiveFace => Enum.Parse<FaceType>(_faceRenderer.sharedMesh.name.Split("_")[2].ToCapital());

        public void SetFaces(Mesh[] faceMeshes)
        {
            _faceMeshes = faceMeshes.Select(m => new FaceMesh(m)).ToArray();
        }

        public bool HasFace(FaceType face)
        {
            var faceMesh = _faceMeshes.FirstOrDefault(m => m.Type == face);

            return faceMesh != null;
        }

        public void PickFace(FaceType faceType)
        {
            var faceMesh = _faceMeshes.FirstOrDefault(m => m.Type == faceType);
            if (faceMesh == null)
            {
                throw new Exception($"Face not found: {faceType.ToString()}.");
            }

            _faceRenderer.sharedMesh = faceMesh.Mesh;
        }

        private void Start()
        {
            ValidateFields();
        }

        private void OnValidate()
        {
            ValidateFields();
        }

        private void ValidateFields()
        {
            _faceRenderer = transform
                .Cast<Transform>()
                .First(t => t.name.StartsWith("Face"))
                .GetComponent<SkinnedMeshRenderer>();
        }
    }
}