// Warning, read the documentation before to set the configurations
// Just change, you may change every variable below

EXPORT modparameters:= MODULE

    // Workunit config
    // Set name's workunit
    // Set priorities work unit, may be use, 'High' or 'normal' or 'low' just.
    EXPORT STRING sNameWU := ''; 
    EXPORT STRING sPriorityWU := 'High'; 
    
    // Input full base
    // Default value empty
    EXPORT STRING sInputFileFull := ''; 
    
    // Control base clipping scheme, it is possible to use a consumption variable or import a clipping base
    // If you want to use a clipping boundary, leave the customer base field blank
    // Default value 0 (zero)
    EXPORT UNSIGNED uLimitRecort := 0; 

    // If you want to use the customer base for clipping, leave consumption at '0'
    // Default value empty
    EXPORT STRING sInputFileClient := ''; 
    
END;
