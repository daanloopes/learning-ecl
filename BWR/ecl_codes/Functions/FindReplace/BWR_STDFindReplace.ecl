IMPORT STD, BWR.ecl_codes.Layouts;

lInputDefault :=  Layouts.modLayouts.lInput;
lOutputDefault := Layouts.modLayouts.lOutput;

dInputDefault := DATASET([{'448.221.778-66', 'Danilo'},
                          {'184.715.875-72','Jose'}],
                        lInputDefault);

dOutputNewLayout := PROJECT(dInputDefault, TRANSFORM(lOutputDefault, SELF.CPF := LEFT.CPF , SELF.DATE := (STRING) STD.Date.Today()));

//Function to find and replace 
dDefaultCleaned := PROJECT(dOutputNewLayout, TRANSFORM(lOutputDefault, SELF.DATE := LEFT.DATE, SELF.CPF := STD.Str.FindReplace(LEFT.CPF,'.','')));
dOutputCleaned := PROJECT(dDefaultCleaned, TRANSFORM(lOutputDefault, SELF.DATE := LEFT.DATE, SELF.CPF := STD.Str.FindReplace(LEFT.CPF,'-','')));

// OUTPUT(dInputDefault,named('DefaultBase'));
// OUTPUT(dOutputNewLayout, named('OutputWithNewLayout'));
OUTPUT(dOutputCleaned, named('CleanedCPFBaseFile'));