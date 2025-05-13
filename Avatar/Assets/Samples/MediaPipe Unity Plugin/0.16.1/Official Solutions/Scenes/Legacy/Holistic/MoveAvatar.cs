using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;

// 저장한 관절 정보 가지고 움직이는 클래스 하나
public class MoveAvatar : MonoBehaviour
{
    private List<AvatarData> limbsJointData;
    private List<AvatarData> handsJointData;
    private Dictionary<string, AvatarData> torsoJointData;
    
    const float LimbsAmount = 0.55f;
    const float Speed = 8f;

    public void SetRequiredData(List<AvatarData> limbsJointData, List<AvatarData> handsJointData, Dictionary<string, AvatarData> torsoJointData)
    {
        this.limbsJointData = limbsJointData;
        this.torsoJointData = torsoJointData;
        this.handsJointData = handsJointData;
    }

    //모든 관절 데이터 지우는 함수
    public void ClearAllData()
    {
        limbsJointData.Clear();
        torsoJointData.Clear();
        handsJointData.Clear();
    }

    //팔다리 관절 움직이는 함수
    public void MoveLimbs()
    {
        
        // MoveLimbs() 함수 내에서
        foreach (var i in limbsJointData)
        {
            
            Vector3 targetDir = Vector3.Slerp(i.initialDir, i.CurrentDirection, LimbsAmount);
            Quaternion fromRotation = Quaternion.LookRotation(i.initialDir);
            Quaternion toRotation = Quaternion.LookRotation(targetDir);
            Quaternion deltaRotation = toRotation * Quaternion.Inverse(fromRotation);

            if (i.allowedAxis != Vector3.zero)
            {
                // deltaRotation을 오일러 각도로 변환
                Vector3 euler = deltaRotation.eulerAngles;

                // 허용 축만 남기고 0으로 세팅
                Vector3 filteredEuler = new Vector3(
                    i.allowedAxis.x != 0 ? euler.x : 0,
                    i.allowedAxis.y != 0 ? euler.y : 0,
                    i.allowedAxis.z != 0 ? euler.z : 0
                );

                deltaRotation = Quaternion.Euler(filteredEuler);
            }

            // 4. 초기 회전값과 합성해서 적용 (회전 누적 방지)
            i.parent.rotation = deltaRotation * i.initialRotation;
            // 🔍 Debug 로그로 문제 회전 탐지
            if (Quaternion.Dot(i.parent.rotation, Quaternion.identity) < 0.1f || float.IsNaN(i.parent.rotation.x))
            {
                Debug.LogWarning($"[회전 문제] {i.parent.name} 회전값 이상: {i.parent.rotation.eulerAngles}");
            }
        }
        
    }
    
    public void MoveHand()
    {
        // foreach (var i in handsJointData)
        // {
        //     
        //     Quaternion changeRot = Quaternion.FromToRotation(i.initialDir, Vector3.Slerp(i.initialDir, i.CurrentDirection, 2.1f));
        //     i.parent.rotation = changeRot * i.initialRotation;
        // }
        
        foreach (var i in handsJointData)
        {
            // 방법 2: LookRotation을 사용한 보다 안정적인 회전 계산
            Vector3 targetDir = Vector3.Slerp(i.initialDir, i.CurrentDirection, LimbsAmount);
        
            // 초기 방향 기준으로 최종 회전 계산 (더 안정적인 방식)
            Quaternion fromRotation = Quaternion.LookRotation(i.initialDir);
            Quaternion toRotation = Quaternion.LookRotation(targetDir);
            Quaternion targetRotation = toRotation * Quaternion.Inverse(fromRotation) * i.initialRotation;
        
            // 직접 적용 (회전 누적 방지)
            i.parent.rotation = targetRotation;
        
            // 디버깅 코드
            if (Quaternion.Dot(i.parent.rotation, Quaternion.identity) < 0.1f || float.IsNaN(i.parent.rotation.x))
            {
                Debug.LogWarning($"[회전 문제] {i.parent.name} 회전값 이상: {i.parent.rotation.eulerAngles}");
            }
        }
        
    }

    //일정 비율만큼 몸통에 있는 관절 회전시키는 함수
    public void RotateTorso(AvatarData avatarData, float amount)
    {
        Quaternion targetRotation;

        targetRotation = Quaternion.FromToRotation(avatarData.initialDir, Vector3.Slerp(avatarData.initialDir, avatarData.CurrentDirection, amount));
        targetRotation *= avatarData.initialRotation;
        avatarData.parent.rotation = Quaternion.Lerp(avatarData.parent.rotation, targetRotation, Time.deltaTime * Speed);
    }

    //몸통 움직이는 함수
    public void MoveTorso()
    {
        // RotateTorso(torsoJointData["rightHip"], 0.5f);
        // RotateTorso(torsoJointData["leftHip"], 0.5f);
        RotateTorso(torsoJointData["neckTwist"], 0.5f);
        RotateTorso(torsoJointData["rightShoulder"], 0.5f);
        RotateTorso(torsoJointData["leftShoulder"], 0.5f);
    }


}