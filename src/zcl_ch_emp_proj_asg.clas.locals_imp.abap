CLASS lhc_zr_ch_emp_proj_asg DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR EmpToProject
        RESULT result,
      valMandatoryCol FOR VALIDATE ON SAVE
        IMPORTING keys FOR EmpToProject~valMandatoryCol,
      detAllottedManDays FOR DETERMINE ON SAVE
        IMPORTING keys FOR EmpToProject~detAllottedManDays.
ENDCLASS.

CLASS lhc_zr_ch_emp_proj_asg IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD valMandatoryCol.

    READ ENTITIES OF zr_ch_emp_proj_asg IN LOCAL MODE
       ENTITY EmpToProject
       FIELDS ( Employeeuuid Projectuuid AllottedHours AllottedManDays )
       WITH CORRESPONDING #( keys )
       RESULT DATA(lt_emp_assgn).

    LOOP AT lt_emp_assgn INTO DATA(ls_emp_assgn).

      IF ls_emp_assgn-Employeeuuid EQ '00000000000000000000000000000000'.

        APPEND VALUE #( %tky = ls_emp_assgn-%tky ) TO failed-emptoproject.

        APPEND VALUE #( %tky                = ls_emp_assgn-%tky
                        %state_area         = 'VALIDATE_EMP_TO_PROJ'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Employee value'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-Employeeuuid = if_abap_behv=>mk-on
                      ) TO reported-emptoproject.

      ELSE.

        SELECT COUNT( * )
            FROM zch_employee
            WHERE employeeuuid EQ @ls_emp_assgn-Employeeuuid
            INTO @DATA(lv_count).

        IF ( lv_count EQ 0 ).

          APPEND VALUE #( %tky = ls_emp_assgn-%tky ) TO failed-emptoproject.

          APPEND VALUE #( %tky                = ls_emp_assgn-%tky
                          %state_area         = 'VALIDATE_EMP_TO_PROJ'
                          %msg                = new_message_with_text(
                                                                  text = 'Enter Valid Employee'
                                                                  severity = if_abap_behv_message=>severity-error )
                          %element-Employeeuuid = if_abap_behv=>mk-on
                        ) TO reported-emptoproject.

        ENDIF.

      ENDIF.

      IF ls_emp_assgn-Projectuuid EQ '00000000000000000000000000000000'.

        APPEND VALUE #( %tky = ls_emp_assgn-%tky ) TO failed-emptoproject.

        APPEND VALUE #( %tky                = ls_emp_assgn-%tky
                        %state_area         = 'VALIDATE_EMP_TO_PROJ'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Project value'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-Projectuuid = if_abap_behv=>mk-on
                      ) TO reported-emptoproject.

      ELSE.

        CLEAR lv_count.

        SELECT COUNT( * )
            FROM zch_project
            WHERE projectuuid EQ @ls_emp_assgn-Projectuuid
            INTO @lv_count.

        IF ( lv_count EQ 0 ).

          APPEND VALUE #( %tky = ls_emp_assgn-%tky ) TO failed-emptoproject.

          APPEND VALUE #( %tky                = ls_emp_assgn-%tky
                          %state_area         = 'VALIDATE_EMP_TO_PROJ'
                          %msg                = new_message_with_text(
                                                                  text = 'Enter Valid Project'
                                                                  severity = if_abap_behv_message=>severity-error )
                          %element-Projectuuid = if_abap_behv=>mk-on
                        ) TO reported-emptoproject.

        ENDIF.


      ENDIF.

      IF ls_emp_assgn-AllottedHours EQ 0.

        APPEND VALUE #( %tky = ls_emp_assgn-%tky ) TO failed-emptoproject.

        APPEND VALUE #( %tky                = ls_emp_assgn-%tky
                        %state_area         = 'VALIDATE_EMP_TO_PROJ'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Allotted Hours value '
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-AllottedHours = if_abap_behv=>mk-on
                      ) TO reported-emptoproject.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD detAllottedManDays.

    READ ENTITIES OF zr_ch_emp_proj_asg IN LOCAL MODE
      ENTITY EmpToProject
      FIELDS ( AllottedHours )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_emp_assgn).

    DELETE lt_emp_assgn WHERE allottedhours EQ 0.

    CHECK lt_emp_assgn IS NOT INITIAL.

    MODIFY ENTITIES OF zr_ch_emp_proj_asg IN LOCAL MODE
      ENTITY EmpToProject
      UPDATE FROM VALUE #( FOR ls IN lt_emp_assgn (
                                             %tky = ls-%tky
                                             %control-AllottedManDays = if_abap_behv=>mk-on
                                             AllottedManDays = ls-AllottedHours / 8 ) )
      REPORTED DATA(reported1).

    reported = CORRESPONDING #( DEEP reported1 ).

  ENDMETHOD.

ENDCLASS.
