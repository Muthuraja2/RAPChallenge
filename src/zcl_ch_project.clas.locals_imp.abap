CLASS lhc_zr_ch_project DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Project
        RESULT result,
      valMandatoryCol FOR VALIDATE ON SAVE
        IMPORTING keys FOR Project~valMandatoryCol.
ENDCLASS.

CLASS lhc_zr_ch_project IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD valMandatoryCol.

    READ ENTITIES OF zr_ch_project IN LOCAL MODE
      ENTITY Project
      FIELDS ( ProjectName ProjectStartDate CustomerName )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_project).

    LOOP AT lt_project INTO DATA(ls_project).

      IF ls_project-ProjectName IS INITIAL.

        APPEND VALUE #( %tky = ls_project-%tky ) TO failed-project.

        APPEND VALUE #( %tky                = ls_project-%tky
                        %state_area         = 'VALIDATE_MANDATORY'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Project Name'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-ProjectName = if_abap_behv=>mk-on
                      ) TO reported-project.
      ENDIF.

      IF ls_project-CustomerName IS INITIAL.

        APPEND VALUE #( %tky = ls_project-%tky ) TO failed-project.

        APPEND VALUE #( %tky                = ls_project-%tky
                        %state_area         = 'VALIDATE_MANDATORY'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Customer Name'
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-CustomerName = if_abap_behv=>mk-on
                      ) TO reported-project.
      ENDIF.

      IF ls_project-ProjectStartDate EQ '00000000'.

        APPEND VALUE #( %tky = ls_project-%tky ) TO failed-project.

        APPEND VALUE #( %tky                = ls_project-%tky
                        %state_area         = 'VALIDATE_MANDATORY'
                        %msg                = new_message_with_text(
                                                                text = 'Enter Project Start Date value '
                                                                severity = if_abap_behv_message=>severity-error )
                        %element-ProjectStartDate = if_abap_behv=>mk-on
                      ) TO reported-project.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
