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

    //Private Func
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
        anoCap: &TeacherCap
        academy: &mut Academy
    ){
        academy.discipline_stud = true
    }

}