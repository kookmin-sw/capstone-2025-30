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
    
    const float LimbsAmount = 0.65f;
    const float Speed = 5f;

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
        // foreach (var i in limbsJointData) {
        //     // 기존 코드
        //     // Quaternion changeRot = Quaternion.FromToRotation(i.initialDir, Vector3.Slerp(i.initialDir, i.CurrentDirection, LimbsAmount));
        //
        //     // 정밀도 개선을 위한 미세 조정
             // Vector3 targetDir = Vector3.Slerp(i.initialDir, i.CurrentDirection, LimbsAmount);
             // Quaternion changeRot = Quaternion.FromToRotation(i.initialDir, targetDir);
        //
        //     // 과도한 회전 제한 (선택적)
        // float angle;
        // Vector3 axis;
        // changeRot.ToAngleAxis(out angle, out axis);
        // if (angle > 120f) {
        //     angle = 120f;
        //     changeRot = Quaternion.AngleAxis(angle, axis);
        // }
        //
        // i.parent.rotation = changeRot * i.initialRotation;
        // }
        foreach (var i in limbsJointData)
        {
            // Quaternion changeRot = Quaternion.FromToRotation(i.initialDir, Vector3.Slerp(i.initialDir, i.CurrentDirection, LimbsAmount));
            // i.parent.rotation = changeRot * i.initialRotation;
            Vector3 targetDir = Vector3.Slerp(i.initialDir, i.CurrentDirection, LimbsAmount);
            Quaternion changeRot = Quaternion.FromToRotation(i.initialDir, targetDir);
            // Quaternion changeRot = Quaternion.Euler(i.initialDir, targetDir);
            
            // float angle;
            // Vector3 axis;
            // changeRot.ToAngleAxis(out angle, out axis);
            // if (angle > 150f) {
            //     angle = 150f;
            //     changeRot = Quaternion.AngleAxis(angle, axis);
            // }
        
            i.parent.rotation = changeRot * i.initialRotation;
        }
    }
    public void MoveHand()
    {
        foreach (var i in handsJointData)
        {
            
            Quaternion changeRot = Quaternion.FromToRotation(i.initialDir, Vector3.Slerp(i.initialDir, i.CurrentDirection, LimbsAmount));
            
            i.parent.rotation = changeRot * i.initialRotation;
            // i.parent.localRotation = Quaternion.identity;
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
        RotateTorso(torsoJointData["rightHip"], 0.5f);
        RotateTorso(torsoJointData["leftHip"], 0.5f);
        RotateTorso(torsoJointData["neckTwist"], 0.5f);
        RotateTorso(torsoJointData["rightShoulder"], 0.3f);
        RotateTorso(torsoJointData["leftShoulder"], 0.3f);
    }

}