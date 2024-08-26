CLASS lhc_zr_ch_timesheet DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Timesheet
        RESULT result,
      valMandatoryCol FOR VALIDATE ON SAVE
        IMPORTING keys FOR Timesheet~valMandatoryCol.
ENDCLASS.

CLASS lhc_zr_ch_timesheet IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD valMandatoryCol.

    READ ENTITIES OF zr_ch_timesheet IN LOCAL MODE
         ENTITY Timesheet
         FIELDS ( Projectuuid Employeeuuid WorkingDate WorkingHours )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_timesheet).

    LOOP AT lt_timesheet INTO DATA(ls_timesheet).

      IF ls_timesheet-Employeeuuid EQ '00000000000000000000000000000000'.

        APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

        APPEND VALUE #( %tky                = ls_timesheet-%tky
                        %state_area         = 'VALIDATE_TIMESHEET'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Employee value'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-Employeeuuid = if_abap_behv=>mk-on
                      ) TO reported-timesheet.

      ELSE.

        SELECT COUNT( * )
            FROM zch_employee
            WHERE employeeuuid EQ @ls_timesheet-Employeeuuid
            INTO @DATA(lv_count).

        IF ( lv_count EQ 0 ).

          APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

          APPEND VALUE #( %tky                = ls_timesheet-%tky
                          %state_area         = 'VALIDATE_TIMESHEET'
                          %msg                = new_message_with_text(
                                                                  text = 'Enter Valid Employee'
                                                                  severity = if_abap_behv_message=>severity-error )
                          %element-Employeeuuid = if_abap_behv=>mk-on
                        ) TO reported-timesheet.

        ENDIF.

      ENDIF.

      IF ls_timesheet-Projectuuid EQ '00000000000000000000000000000000'.

        APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

        APPEND VALUE #( %tky                = ls_timesheet-%tky
                        %state_area         = 'VALIDATE_TIMESHEET'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Project value'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-Projectuuid = if_abap_behv=>mk-on
                      ) TO reported-timesheet.

      ELSE.

        CLEAR lv_count.

        SELECT COUNT( * )
            FROM zch_project
            WHERE projectuuid EQ @ls_timesheet-Projectuuid
            INTO @lv_count.

        IF ( lv_count EQ 0 ).

          APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

          APPEND VALUE #( %tky                = ls_timesheet-%tky
                          %state_area         = 'VALIDATE_TIMESHEET'
                          %msg                = new_message_with_text(
                                                                  text = 'Enter Valid Project'
                                                                  severity = if_abap_behv_message=>severity-error )
                          %element-Projectuuid = if_abap_behv=>mk-on
                        ) TO reported-timesheet.

        ENDIF.


      ENDIF.

      IF ls_timesheet-WorkingDate EQ '00000000'.

        APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

        APPEND VALUE #( %tky                = ls_timesheet-%tky
                        %state_area         = 'VALIDATE_TIMESHEET'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Working Date'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-WorkingDate = if_abap_behv=>mk-on
                      ) TO reported-timesheet.

      ELSE.

        IF ls_timesheet-WorkingDate > sy-datum.

          APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

          APPEND VALUE #( %tky                = ls_timesheet-%tky
                          %state_area         = 'VALIDATE_TIMESHEET'
                          %msg                = new_message_with_text(
                                                                  text = 'Working Date should not be in Future'
                                                                  severity = if_abap_behv_message=>severity-error )
                          %element-WorkingDate = if_abap_behv=>mk-on
                        ) TO reported-timesheet.

        ENDIF.

      ENDIF.


      IF ls_timesheet-WorkingHours IS INITIAL.

        APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

        APPEND VALUE #( %tky                = ls_timesheet-%tky
                        %state_area         = 'VALIDATE_TIMESHEET'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Working Hours'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-WorkingHours = if_abap_behv=>mk-on
                      ) TO reported-timesheet.

      ELSE.

        IF NOT ls_timesheet-WorkingHours BETWEEN 0 AND 24.

          APPEND VALUE #( %tky = ls_timesheet-%tky ) TO failed-timesheet.

          APPEND VALUE #( %tky                = ls_timesheet-%tky
                          %state_area         = 'VALIDATE_TIMESHEET'
                          %msg                = new_message_with_text(
                                                                  text = 'Enter a valid Working hours'
                                                                  severity = if_abap_behv_message=>severity-error )
                          %element-WorkingHours = if_abap_behv=>mk-on
                        ) TO reported-timesheet.
        ENDIF.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
