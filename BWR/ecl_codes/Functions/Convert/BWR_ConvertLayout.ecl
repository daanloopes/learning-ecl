IMPORT STD, BWR.ecl_codes.Layouts;

STRING sDate := (STRING) STD.Date.Today()          :INDEPENDENT;
STRING sTime := (STRING) STD.Date.CurrentTime()    :INDEPENDENT;

#WORKUNIT('priority','High');

STRING sLogicalInputFileName  := '~learning::input::sample_base.csv';

//Import layouts
LayoutInputFile := Layouts.modLayouts.DefaultLayoutSampleBaseDelimited;
LayoutHelper := Layouts.modLayouts.DefaultLayoutSampleBaseFixed_Helper;
LayoutHeader := Layouts.modLayouts.DefaultLayoutSampleBaseFixed_Header;
LayoutDetail := Layouts.modLayouts.DefaultLayoutSampleBaseFixed_Detail;
LayoutTrailler := Layouts.modLayouts.DefaultLayoutSampleBaseFixed_Trailler;

//Create Header
dCreateHeader := DATASET([{'00',sDate,sTime,'              '}], LayoutHeader);

dHeader := PROJECT(dCreateHeader, TRANSFORM(LayoutHelper,
                                            SELF.field := LEFT.cod_reg +
                                            LEFT.date_reference +
                                            LEFT.current_time + 
                                            LEFT.filler
)):INDEPENDENT;

//Create Detail
dInput := SORT(DISTRIBUTE(DATASET(sLogicalInputFileName, LayoutInputFile, CSV(HEADING(1), SEPARATOR(','))),HASH(cpf)),cpf,LOCAL);

dConvertInput := PROJECT(dInput, TRANSFORM(LayoutDetail,
                                            SELF.cod_reg    := '01';
                                            SELF.cpf        := INTFORMAT(LEFT.cpf,11,1);
                                            SELF.entity     := 'F';
                                            SELF.score      := INTFORMAT(LEFT.score,6,1);
                                            SELF.filler     := '          ';
));

dDetail := PROJECT(dConvertInput, TRANSFORM(LayoutHelper, 
                                            SELF.field := LEFT.cod_reg +
                                            LEFT.cpf +
                                            LEFT.entity +
                                            LEFT.score +
                                            LEFT.filler
)):INDEPENDENT;

aCountDetail := COUNT(dDetail):INDEPENDENT;

//Create Trailler
dCreateTrailler := DATASET([{'99',aCountDetail,'                 '}], LayoutTrailler);

dTrailler := PROJECT(dCreateTrailler, TRANSFORM(LayoutHelper, 
                                            SELF.field := LEFT.cod_reg +
                                            INTFORMAT((UNSIGNED) LEFT.count_detail,11,1) +
                                            LEFT.filler
)):INDEPENDENT;

//Join Datasets
dJoinProduct := dHeader + dDetail + dTrailler;
dProduct := SORT(dJoinProduct,field,SKEW(1.0)):INDEPENDENT;
aCountFullBase := COUNT(dProduct):INDEPENDENT;

//Show Outputs
OUTPUT(dHeader,NAMED('ShowdHeader'));
OUTPUT(CHOOSEN(dDetail,10),NAMED('ShowdDetail'));
OUTPUT(dTrailler,NAMED('ShowdTrailler'));

OUTPUT(aCountDetail,NAMED('CountDetail'));
OUTPUT(aCountFullBase,NAMED('CountFullBase'));

OUTPUT(dProduct,NAMED('ShowFinalBase'));