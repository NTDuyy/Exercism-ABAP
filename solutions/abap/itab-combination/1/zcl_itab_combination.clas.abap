CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type WITH EMPTY KEY.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type WITH EMPTY KEY.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas TYPE alphas
        nums   TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.
    DATA: wa_combinedrow TYPE combined_data_type,
          alphas_row     TYPE alphatab_type,
          nums_row       TYPE numtab_type,
        len_alphas     TYPE i,
        len_nums       TYPE i,
        min_len        TYPE i.

    DESCRIBE TABLE alphas LINES len_alphas.
    DESCRIBE TABLE nums   LINES len_nums.
  
    " Use minimum length to avoid index errors
    IF len_alphas < len_nums.
      min_len = len_alphas.
    ELSE.
      min_len = len_nums.
    ENDIF.


    DO min_len times.
      READ TABLE alphas INDEX sy-index INTO alphas_row.
      READ TABLE nums INDEX sy-index INTO nums_row.
      
      wa_combinedrow-colx = alphas_row-cola && |{ nums_row-col1 }|.
      wa_combinedrow-coly = alphas_row-colb && |{ nums_row-col2 }|.
      wa_combinedrow-colz = alphas_row-colc && |{ nums_row-col3 }|.
      APPEND wa_combinedrow TO combined_data.
    ENDDO.

  ENDMETHOD.

ENDCLASS.

