/***
Create a smaller data csv data from the lager national data set
***/

data SBAnational; 
  infile 'C:\Users\75CPENG\OneDrive - West Chester University of PA\Desktop\cpeng\WCU-Teaching\2020Fall\STA490\SBAnational.csv' DLM=',' FIRSTOBS=2 DSD MISSOVER;
  input
        LoanNr_ChkDgt    : BEST10.
        Name             : $CHAR30.
        City             : $CHAR30.
        State            : $CHAR2.
        Zip              : BEST5.
        Bank             : $CHAR30.
        BankState        : $CHAR2.
        NAICS            : BEST6.
        ApprovalDate     : DATE9.
        ApprovalFY       : $CHAR5.
        Term             : BEST3.
        NoEmp            : BEST4.
        NewExist         : BEST1.
        CreateJob        : BEST4.
        RetainedJob      : BEST4.
        FranchiseCode    : BEST5.
        UrbanRural       : BEST1.
        RevLineCr        : $CHAR1.
        LowDoc           : $CHAR1.
        ChgOffDate       : DATE9.
        DisbursementDate : DATE9.
        DisbursementGross : DOLLAR15.
        BalanceGross     : DOLLAR12.
        MIS_Status       : $CHAR6.
        ChgOffPrinGr     : DOLLAR14.
        GrAppv           : DOLLAR14.
        SBA_Appv         : DOLLAR14. ;

if MIS_Status='CHGOFF' then y=1; else y=0;  /* If the loan is charged off, the response y is set to be 1. */
    if NewExist='2' then New=1; else New=0;  /* x1=1 if the business is less than 2 years old; x1=0 if the business is more than 2 years old */
    if Term ge 240 then RealEstate=1; else RealEstate=0; /*x2=1 if loans secured by real estate */
run;

data one; set SBAnational;  
if DisbursementDate <='31DEC2010'd; /* Exclude loans disbursed after 2010; see Section 3.3; */
  NAICS_2=INT(NAICS/10000); /* Extract first two digits of NAICS code */
run;

data two; set one;
  if State eq 'CA' AND NAICS_2 eq 53; /* The case study only uses "SBA Case" data */
  Portion=SBA_Appv/GrAppv;
  proc freq; tables MIS_Status;  /* This frequency table shows 32.64% of the loans were charged off or defaulted. */
run;   

data ca53;
  set two;
  PROC SURVEYSELECT OUTALL OUT=dataca53 METHOD=SRS
  SAMPSIZE=1051 SEED=18467; *training and test;
  RUN;

data SBAcase;
  set dataca53;
   Recession=0;
   y1=y;
   daysterm=Term*30;
   xx=DisbursementDate+daysterm;
  if Selected=0 then y1=.;
     Default=y1;
  if xx  ge '1DEC2007'd AND xx le '30JUN2009'd then Recession=1;
run;

data casedata; set SBAcase (drop=y y1 NAICS_2); 
  proc export data=casedata outfile='C:\Users\75CPENG\OneDrive - West Chester University of PA\Desktop\cpeng\WCU-Teaching\2020Fall\STA490\SBAcase.csv' DBMS=CSV REPLACE; /*Create the CA dataset.  The dates are in SAS format. */
run;
