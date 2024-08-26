CLASS lhc_zr_ch_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Employee
        RESULT result,
      valMandatoryCol FOR VALIDATE ON SAVE
        IMPORTING keys FOR Employee~valMandatoryCol.
ENDCLASS.

CLASS lhc_zr_ch_employee IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD valMandatoryCol.

    READ ENTITIES OF zr_ch_employee IN LOCAL MODE
        ENTITY Employee
        FIELDS ( EmployeeFirstName CostCenter StartDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_employee).

    LOOP AT lt_employee INTO DATA(ls_employee).

      IF ls_employee-EmployeeFirstName IS INITIAL.

        APPEND VALUE #( %tky = ls_employee-%tky ) TO failed-employee.

        APPEND VALUE #( %tky                = ls_employee-%tky
                        %state_area         = 'VALIDATE_MANDATORY'
                        %msg                = new_message_with_text(
                                                                text = 'Enter First Name of Employee'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-EmployeeFirstName = if_abap_behv=>mk-on
                      ) TO reported-employee.
      ENDIF.

      IF ls_employee-CostCenter IS INITIAL.

        APPEND VALUE #( %tky = ls_employee-%tky ) TO failed-employee.

        APPEND VALUE #( %tky                = ls_employee-%tky
                        %state_area         = 'VALIDATE_MANDATORY'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Cost Center value'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-CostCenter = if_abap_behv=>mk-on
                      ) TO reported-employee.
      ENDIF.

      IF ls_employee-StartDate EQ '00000000'.

        APPEND VALUE #( %tky = ls_employee-%tky ) TO failed-employee.

        APPEND VALUE #( %tky                = ls_employee-%tky
                        %state_area         = 'VALIDATE_MANDATORY'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Start Date value '
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-StartDate = if_abap_behv=>mk-on
                      ) TO reported-employee.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
