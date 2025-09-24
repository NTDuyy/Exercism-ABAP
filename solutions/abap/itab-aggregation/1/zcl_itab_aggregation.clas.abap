CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    TYPES: ty_group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE ty_group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.
    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE ty_group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.
    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    DATA: sum_num TYPE p,
          cnt     TYPE i,
          min_num TYPE p,
          max_num TYPE p,
          wa      TYPE aggregated_data_type.
    FIELD-SYMBOLS: <row> TYPE initial_numbers_type.
    SORT initial_numbers BY group.
    LOOP AT initial_numbers ASSIGNING <row>.
      AT NEW group.
        CLEAR: sum_num, cnt, min_num, max_num.
        min_num = <row>-number.
        max_num = <row>-number.
      ENDAT.
      " Aggregation logic
      IF min_num > <row>-number.
        min_num = <row>-number.
      ENDIF.
      IF max_num < <row>-number.
        max_num = <row>-number.
      ENDIF.
      ADD 1 TO cnt.
      ADD <row>-number TO sum_num.
      AT END OF group.
        CLEAR wa.
        wa-group   = <row>-group.
        wa-count   = cnt.
        wa-sum     = sum_num.
        wa-min     = min_num.
        wa-max     = max_num.
        IF cnt > 0.
          wa-average = sum_num / cnt.
        ELSE.
          wa-average = 0.
        ENDIF.
        APPEND wa TO aggregated_data.
      ENDAT.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
