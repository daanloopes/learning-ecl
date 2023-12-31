//This module can be used to specify any layout within the entire learning-ecl project

EXPORT modLayouts := MODULE

    //Layout for ~learning::input::sample_base.csv
    EXPORT DefaultLayoutSampleBaseDelimited := RECORD
        UNSIGNED cpf;
        STRING name;
        STRING country;
        UNSIGNED score;
    END;

    //Layout for ~learning::input::sample_base.csv
    EXPORT DefaultLayoutSampleBaseFixed_Header := RECORD
        STRING02 cod_reg;
        STRING08 date_reference;
        STRING06 current_time;
        STRING14 filler;
    END;

    //Layout for ~learning::input::sample_base.csv
    EXPORT DefaultLayoutSampleBaseFixed_Detail := RECORD
        STRING02 cod_reg;
        STRING11 cpf;
        STRING01 entity;
        STRING06 score;
        STRING10 filler;
    END;

    //Layout for ~learning::input::sample_base.csv
    EXPORT DefaultLayoutSampleBaseFixed_Trailler := RECORD
        STRING02 cod_reg;
        STRING11 count_detail;
        STRING17 filler;
    END;

    //Layout for ~learning::input::sample_base.csv
    EXPORT DefaultLayoutSampleBaseFixed_Helper := RECORD
        STRING30 field;
    END;
    
    //Layout for ~learning::input::persons.csv
    EXPORT lBaseInput := RECORD
        UNSIGNED id;
        STRING firstname;
    END;
 
    //Layout for FindReplace BWRs
    EXPORT lInput := RECORD
        STRING CPF;
        STRING NAME;
    END;

    //Layout for FindReplace BWRs
    EXPORT lOutput := RECORD
        STRING CPF;
        STRING DATE;
    END;

END;
