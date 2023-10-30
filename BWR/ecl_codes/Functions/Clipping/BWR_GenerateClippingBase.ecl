// Warning, check the layout base before running
// To customize the attributes of this execution, please change the file, modParameters
// To customize, please change the file, modLayouts
// Don't need to change anything below, just run
IMPORT BWR.ecl_codes.Functions.Clipping, BWR.ecl_codes.Layouts; 

#WORKUNIT('name', Clipping.modParameters.sNameWU);
#WORKUNIT('priority', Clipping.modParameters.sPriorityWU);

// Import modLayouts
lRawDefault := Layouts.modLayouts.lBaseInput;

// Import modParameters
sRawFull := Clipping.modParameters.sInputFileFull;
sRawClient := Clipping.modParameters.sInputFileClient;
uRawLimitRecort := Clipping.modParameters.uLimitRecort;

// Applying clipping into the datasets
// Consumption variable
dBaseFull := IF(sRawClient = '',
    CHOOSEN(DEDUP(DATASET(sRawFull, lRawDefault, CSV(HEADING(1), SEPARATOR(','), UNICODE)),id),uRawLimitRecort)
    //SAMPLE(DEDUP(DATASET(sRawFull, lRawDefault, CSV(HEADING(1), SEPARATOR(','), UNICODE)),id),uRawLimitRecort)
);

// IF False -> Customer base clipping
dInputID := IF(sRawClient <> '',
    DEDUP(DATASET(sRawClient, lRawDefault, CSV(HEADING(1), SEPARATOR(','), UNICODE)),id)
    //SAMPLE(DATASET(sRawClient, lRawDefault, CSV(HEADING(1), SEPARATOR(','), UNICODE)),id)
);

//Attributing datasets in the final base, 
//Using condition to choose whether the chosen rule will use the customer base or the consumption limit variable
dRecorteFinalBase := IF(sRawClient = '',
    // IF True  -> Consumption variable
    PROJECT(dBaseFull, TRANSFORM(lRawDefault, SELF := LEFT)),
    // IF False -> Customer base clipping
    PROJECT(dInputID, TRANSFORM(lRawDefault, SELF := LEFT))
);

//Outputs samples
OUTPUT(CHOOSEN(dBaseFull,100), named('ViewSampleBaseFullFile'));
OUTPUT(CHOOSEN(dInputID,100),named('ViewClientFile'));

//Outputs count values
OUTPUT(COUNT(dBaseFull),named('CountRawFullFile'));
OUTPUT(COUNT(dInputID),named('CountClientFile'));

//Output Final Base
OUTPUT(dRecorteFinalBase,named('ClippedBase'));



