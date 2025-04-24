using UnityEngine;

public class AvatarData : MonoBehaviour
{
    public Transform parent, child;    // 캐릭터 부모 조인트, 자식 조인트 transform 저장
    public Vector3 tParent, tChild;    //트래킹하는 부모 조인트 x,y,z 위치값, 자식 조인트 x,y,z 위치값
    public Vector3 initialDir;         // 캐릭터 조인트 움직이기 전 자식, 부모조인트의 상대 위치 --> 관절 회전값 바꾸는데 쓰임
    public Quaternion initialRotation; //캐릭터 조인트 움직이기 전 조인트 회전값

    public Vector3 CurrentDirection => (tChild - tParent).normalized;

    public AvatarData(Transform mParent, Transform mChild, Vector3 tParent, Vector3 tChild)
    {
        initialDir = (mChild.position - mParent.position).normalized;
        initialRotation = mParent.rotation;
        this.parent = mParent;
        this.child = mChild;
        this.tParent = tParent;
        this.tChild = tChild;
    }
}