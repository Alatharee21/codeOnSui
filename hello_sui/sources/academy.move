module hello_sui::academy{
    //Capability
    public struct PrincipalCap has key, store{
        id: UID,
    }
    public struct TeacherCap has key, store{
        id: UID,
    }

    //Struct
    public struct Academy has key, store{
        id: UID,
        fee: u64,
        paused: bool,
        discipline_stud: bool,
    }

    //Public Function
    public fun updateFun(
        _cap: &PrincipalCap,
        academy: &mut Academy
    ){
        update_fee(_cap, academy);
    }
    public fun pauseAcademy(
        _cap: &PrincipalCap,
        academy: &mut Academy
    ){
        pause_academy(_cap, academy);
    }
    public fun resumeAcademy(
        _cap: &PrincipalCap,
        academy: &mut Academy
    ){
        resume_academy(_cap, academy);
    }

    public fun correctStudent(
        _cap: &PrincipalCap,
        _anoCap: &TeacherCap,
        academy: &mut Academy
    ){
        correct_student(_cap, _anoCap, academy);
    }

    //Helper Func
    fun update_fee(
        _cap: &PrincipalCap,
        academy: &mut Academy
    ){
        academy.fee = academy.fee + 2500
    }

    fun pause_academy(
        _cap: &PrincipalCap,
        academy: &mut Academy
    ){
        academy.paused = true
    }

    fun resume_academy(
        _cap: &PrincipalCap,
        academy: &mut Academy
    ){
        academy.paused = false
    }

    fun correct_student(
        _cap: &PrincipalCap,
        _anoCap: &TeacherCap,
        academy: &mut Academy
    ){
        academy.discipline_stud = true
    }

}