CLASS zcl_itab_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_type,
             group       TYPE group,
             number      TYPE i,
             description TYPE string,
           END OF initial_type,
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY.

    METHODS fill_itab
           RETURNING
             VALUE(initial_data) TYPE itab_data_type.

    METHODS add_to_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.

    METHODS sort_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.

    METHODS search_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
             VALUE(result_index) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_itab_basics IMPLEMENTATION.
  METHOD fill_itab.
    "add solution here
    DATA: wa_row TYPE initial_type.
    
    wa_row-group = 'A'.
    wa_row-number = 10.
    wa_row-description = 'Group A-2'.
    APPEND wa_row TO initial_data.

    wa_row-group = 'B'.
    wa_row-number = 5.
    wa_row-description = 'Group B'.
    APPEND wa_row TO initial_data.

    wa_row-group = 'A'.
    wa_row-number = 6.
    wa_row-description = 'Group A-1'.
    APPEND wa_row TO initial_data.

    wa_row-group = 'C'.
    wa_row-number = 22.
    wa_row-description = 'Group C-1'.
    APPEND wa_row TO initial_data.

    wa_row-group = 'A'.
    wa_row-number = 13.
    wa_row-description = 'Group A-3'.
    APPEND wa_row TO initial_data.

    wa_row-group = 'C'.
    wa_row-number = 500.
    wa_row-description = 'Group C-2'.
    APPEND wa_row TO initial_data.
    
  ENDMETHOD.

  METHOD add_to_itab.
    updated_data = initial_data.
    "add solution here
    DATA: wa_row TYPE initial_type.
    wa_row-group = 'A'.
    wa_row-number = 19.
    wa_row-description = 'Group A-4'.
    APPEND wa_row TO updated_data.
    
  ENDMETHOD.

  METHOD sort_itab.
    updated_data = initial_data.
    "add solution here
    SORT updated_data BY group ASCENDING number DESCENDING.
  ENDMETHOD.

  METHOD search_itab.
    DATA(temp_data) = initial_data.
    "add solution here
    DATA: wa_row TYPE initial_type.
    CLEAR result_index.
    LOOP AT temp_data INTO wa_row.
      CASE wa_row-number.
        WHEN 6.
          result_index = result_index + 1.
          EXIT.
        WHEN OTHERS.
          result_index = result_index + 1.
      ENDCASE.
  ENDLOOP.
  
  ENDMETHOD.

ENDCLASS.
