* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                ///
  int     year      1-4      ///
  long    serial    5-9      ///
  byte    month     10-11    ///
  double  hwtfinl   12-21    ///
  double  cpsid     22-35    ///
  byte    asecflag  36-36    ///
  byte    hflag     37-37    ///
  double  asecwth   38-47    ///
  double  cpi99     48-51    ///
  byte    pernum    52-53    ///
  double  wtfinl    54-67    ///
  double  cpsidp    68-81    ///
  double  asecwt    82-91    ///
  double  ftotval   92-101   ///
  double  inctot    102-109  ///
  long    incwage   110-116  ///
  long    incbus    117-123  ///
  long    incfarm   124-130  ///
  long    incunern  131-135  ///
  long    incss     136-140  ///
  long    incwelfr  141-145  ///
  long    incgov    146-150  ///
  long    incidr    151-155  ///
  long    incaloth  156-160  ///
  long    incretir  161-166  ///
  long    incssi    167-171  ///
  long    incdrt    172-176  ///
  long    incint    177-181  ///
  long    incunemp  182-186  ///
  long    incwkcom  187-191  ///
  long    incvet    192-196  ///
  long    incsurv   197-202  ///
  long    incdisab  203-208  ///
  long    incdivid  209-214  ///
  long    incrent   215-219  ///
  long    inceduc   220-224  ///
  long    incchild  225-229  ///
  long    incalim   230-234  ///
  long    incasist  235-239  ///
  long    incother  240-244  ///
  byte    gotalch   245-245  ///
  byte    gotregct  246-246  ///
  byte    gotdivid  247-247  ///
  byte    gotelse   248-248  ///
  byte    gotestat  249-249  ///
  byte    gotint    250-250  ///
  byte    gotss     251-251  ///
  byte    gotwelfr  252-252  ///
  byte    gotfedrp  253-253  ///
  byte    gotstlrp  254-254  ///
  byte    gotmilrp  255-255  ///
  byte    gotpvtrp  256-256  ///
  byte    gotrent   257-257  ///
  byte    gotrrrp   258-258  ///
  byte    gotvdisa  259-259  ///
  byte    gotveduc  260-260  ///
  byte    gotvetpa  261-261  ///
  byte    gotvothe  262-262  ///
  byte    gotvpens  263-263  ///
  byte    gotvsurv  264-264  ///
  byte    gotwkcom  265-265  ///
  long    incdisa1  266-270  ///
  long    incdisa2  271-275  ///
  long    inclongj  276-282  ///
  long    increti1  283-287  ///
  long    increti2  288-292  ///
  long    incsurv1  293-297  ///
  long    incsurv2  298-302  ///
  long    mthwelfr  303-307  ///
  long    oincbus   308-313  ///
  long    oincfarm  314-319  ///
  long    oincwage  320-326  ///
  byte    srcdisa1  327-328  ///
  byte    srcdisa2  329-330  ///
  byte    srcearn   331-331  ///
  byte    srceduc   332-332  ///
  byte    srcreti1  333-333  ///
  byte    srcreti2  334-334  ///
  byte    srcssi    335-335  ///
  byte    srcsurv1  336-337  ///
  byte    srcsurv2  338-339  ///
  byte    srcunemp  340-340  ///
  byte    srcwelfr  341-341  ///
  byte    srcwkcom  342-342  ///
  byte    ssikid    343-343  ///
  byte    sskid     344-344  ///
  byte    vetqa     345-345  ///
  byte    whyss1    346-346  ///
  byte    whyss2    347-347  ///
  byte    whyssi1   348-348  ///
  byte    whyssi2   349-349  ///
  byte    gotunemp  350-350  ///
  int     stimulus  351-354  ///
  using `"cps_00007.dat"'

replace hwtfinl  = hwtfinl  / 10000
replace asecwth  = asecwth  / 10000
replace cpi99    = cpi99    / 1000
replace wtfinl   = wtfinl   / 10000
replace asecwt   = asecwt   / 10000

format hwtfinl  %10.4f
format cpsid    %14.0g
format asecwth  %10.4f
format cpi99    %4.3f
format wtfinl   %14.4f
format cpsidp   %14.0g
format asecwt   %10.4f
format ftotval  %10.0g
format inctot   %8.0g

label var year     `"Survey year"'
label var serial   `"Household serial number"'
label var month    `"Month"'
label var hwtfinl  `"Household weight, Basic Monthly"'
label var cpsid    `"CPSID, household record"'
label var asecflag `"Flag for ASEC"'
label var hflag    `"Flag for the 3/8 file 2014"'
label var asecwth  `"Annual Social and Economic Supplement Household weight"'
label var cpi99    `"CPI-U adjustment factor to 1999 dollars"'
label var pernum   `"Person number in sample unit"'
label var wtfinl   `"Final Basic Weight"'
label var cpsidp   `"CPSID, person record"'
label var asecwt   `"Annual Social and Economic Supplement Weight"'
label var ftotval  `"Total family income"'
label var inctot   `"Total personal income"'
label var incwage  `"Wage and salary income"'
label var incbus   `"Non-farm business income"'
label var incfarm  `"Farm income"'
label var incunern `"Income from Source other than earnings"'
label var incss    `"Social Security income"'
label var incwelfr `"Welfare (public assistance) income"'
label var incgov   `"Income from other govt programs"'
label var incidr   `"Income from interest, dividends, and rent"'
label var incaloth `"Income from alimony, contributions, other"'
label var incretir `"Retirement income"'
label var incssi   `"Income from SSI"'
label var incdrt   `"Income from dividends, rent, trusts"'
label var incint   `"Income from interest"'
label var incunemp `"Income from unemployment benefits"'
label var incwkcom `"Income from worker's compensation"'
label var incvet   `"Income from veteran's benefits"'
label var incsurv  `"Income from survivor's benefits"'
label var incdisab `"Income from disability benefits"'
label var incdivid `"Income from dividends"'
label var incrent  `"Income from rent"'
label var inceduc  `"Income from educational assistance"'
label var incchild `"Income from child support"'
label var incalim  `"Income from alimony"'
label var incasist `"Income from assistance"'
label var incother `"Income from other Source not specified"'
label var gotalch  `"Received alimony or child support income"'
label var gotregct `"Received income from regular contributions"'
label var gotdivid `"Received dividend income"'
label var gotelse  `"Received income from anything else not already covered"'
label var gotestat `"Received estates and trusts income"'
label var gotint   `"Received interest income"'
label var gotss    `"Received social security"'
label var gotwelfr `"Received welfare (public assistance) income"'
label var gotfedrp `"Received federal government pension"'
label var gotstlrp `"Received state and local government pension"'
label var gotmilrp `"Received military retirement pension"'
label var gotpvtrp `"Received private retirement pension"'
label var gotrent  `"Received rental or royalties income"'
label var gotrrrp  `"Received railroad retirement pension"'
label var gotvdisa `"Received veterans' disability compensation"'
label var gotveduc `"Received veterans' education assistance"'
label var gotvetpa `"Received veterans' payments"'
label var gotvothe `"Received other veterans' payments"'
label var gotvpens `"Received veterans' pension"'
label var gotvsurv `"Received veterans' survivor benefits"'
label var gotwkcom `"Received worker's compensation"'
label var incdisa1 `"Disability income from first source"'
label var incdisa2 `"Disability income from second source"'
label var inclongj `"Earnings from longest job"'
label var increti1 `"Retirement income from first source"'
label var increti2 `"Retirement income from second source"'
label var incsurv1 `"Survivor benefits income from first source"'
label var incsurv2 `"Survivor benefits income from second source"'
label var mthwelfr `"Number of months received welfare income"'
label var oincbus  `"Earnings from other work included business self-employment earnings"'
label var oincfarm `"Earnings from other work included farm self-employment earnings"'
label var oincwage `"Earnings from other work included wage and salary earnings"'
label var srcdisa1 `"First source of disability income"'
label var srcdisa2 `"Second source of disability income"'
label var srcearn  `"Source of earnings from longest job"'
label var srceduc  `"Source of educational assistance"'
label var srcreti1 `"First source of retirement income"'
label var srcreti2 `"Second source of retirement income"'
label var srcssi   `"Source of supplementary security income"'
label var srcsurv1 `"First source of survivor benefits"'
label var srcsurv2 `"Second source of survivor benefits"'
label var srcunemp `"Source of unemployment income"'
label var srcwelfr `"Source of welfare income"'
label var srcwkcom `"Source of workmen's compensation"'
label var ssikid   `"Child under 18 received SSI income"'
label var sskid    `"Child under 19 received SS income"'
label var vetqa    `"Required to fill out annual income questionnaire for veterans' administration"'
label var whyss1   `"First reason for receiving social security income"'
label var whyss2   `"Second reason for receiving social security income"'
label var whyssi1  `"First reason for receiving supplementary security income"'
label var whyssi2  `"Second reason for receiving supplementary security income"'
label var gotunemp `"Received unemployment compensation"'
label var stimulus `"Federal stimulus payment"'

label define month_lbl 01 `"January"'
label define month_lbl 02 `"February"', add
label define month_lbl 03 `"March"', add
label define month_lbl 04 `"April"', add
label define month_lbl 05 `"May"', add
label define month_lbl 06 `"June"', add
label define month_lbl 07 `"July"', add
label define month_lbl 08 `"August"', add
label define month_lbl 09 `"September"', add
label define month_lbl 10 `"October"', add
label define month_lbl 11 `"November"', add
label define month_lbl 12 `"December"', add
label values month month_lbl

label define asecflag_lbl 1 `"ASEC"'
label define asecflag_lbl 2 `"March Basic"', add
label values asecflag asecflag_lbl

label define hflag_lbl 0 `"5/8 file"'
label define hflag_lbl 1 `"3/8 file"', add
label values hflag hflag_lbl

label define gotalch_lbl 0 `"NIU"'
label define gotalch_lbl 1 `"No"', add
label define gotalch_lbl 2 `"Yes"', add
label values gotalch gotalch_lbl

label define gotregct_lbl 0 `"NIU"'
label define gotregct_lbl 1 `"No"', add
label define gotregct_lbl 2 `"Yes"', add
label values gotregct gotregct_lbl

label define gotdivid_lbl 0 `"NIU"'
label define gotdivid_lbl 1 `"No"', add
label define gotdivid_lbl 2 `"Yes"', add
label values gotdivid gotdivid_lbl

label define gotelse_lbl 0 `"NIU"'
label define gotelse_lbl 1 `"No"', add
label define gotelse_lbl 2 `"Yes"', add
label values gotelse gotelse_lbl

label define gotestat_lbl 0 `"NIU"'
label define gotestat_lbl 1 `"No"', add
label define gotestat_lbl 2 `"Yes"', add
label values gotestat gotestat_lbl

label define gotint_lbl 0 `"NIU"'
label define gotint_lbl 1 `"No"', add
label define gotint_lbl 2 `"Yes"', add
label values gotint gotint_lbl

label define gotss_lbl 0 `"NIU"'
label define gotss_lbl 1 `"No"', add
label define gotss_lbl 2 `"Yes"', add
label values gotss gotss_lbl

label define gotwelfr_lbl 0 `"Blank"'
label define gotwelfr_lbl 1 `"No"', add
label define gotwelfr_lbl 2 `"Yes"', add
label define gotwelfr_lbl 9 `"NIU"', add
label values gotwelfr gotwelfr_lbl

label define gotfedrp_lbl 0 `"NIU"'
label define gotfedrp_lbl 1 `"No"', add
label define gotfedrp_lbl 2 `"Yes"', add
label values gotfedrp gotfedrp_lbl

label define gotstlrp_lbl 0 `"NIU"'
label define gotstlrp_lbl 1 `"No"', add
label define gotstlrp_lbl 2 `"Yes"', add
label values gotstlrp gotstlrp_lbl

label define gotmilrp_lbl 0 `"NIU"'
label define gotmilrp_lbl 1 `"No"', add
label define gotmilrp_lbl 2 `"Yes"', add
label values gotmilrp gotmilrp_lbl

label define gotpvtrp_lbl 0 `"NIU"'
label define gotpvtrp_lbl 1 `"No"', add
label define gotpvtrp_lbl 2 `"Yes"', add
label values gotpvtrp gotpvtrp_lbl

label define gotrent_lbl 0 `"NIU"'
label define gotrent_lbl 1 `"No"', add
label define gotrent_lbl 2 `"Yes"', add
label values gotrent gotrent_lbl

label define gotrrrp_lbl 0 `"NIU"'
label define gotrrrp_lbl 1 `"No"', add
label define gotrrrp_lbl 2 `"Yes"', add
label values gotrrrp gotrrrp_lbl

label define gotvdisa_lbl 0 `"NIU"'
label define gotvdisa_lbl 1 `"No"', add
label define gotvdisa_lbl 2 `"Yes"', add
label values gotvdisa gotvdisa_lbl

label define gotveduc_lbl 0 `"NIU"'
label define gotveduc_lbl 1 `"No"', add
label define gotveduc_lbl 2 `"Yes"', add
label values gotveduc gotveduc_lbl

label define gotvetpa_lbl 0 `"NIU"'
label define gotvetpa_lbl 1 `"No"', add
label define gotvetpa_lbl 2 `"Yes"', add
label values gotvetpa gotvetpa_lbl

label define gotvothe_lbl 0 `"NIU"'
label define gotvothe_lbl 1 `"No"', add
label define gotvothe_lbl 2 `"Yes"', add
label values gotvothe gotvothe_lbl

label define gotvpens_lbl 0 `"NIU"'
label define gotvpens_lbl 1 `"No"', add
label define gotvpens_lbl 2 `"Yes"', add
label values gotvpens gotvpens_lbl

label define gotvsurv_lbl 0 `"NIU"'
label define gotvsurv_lbl 1 `"No"', add
label define gotvsurv_lbl 2 `"Yes"', add
label values gotvsurv gotvsurv_lbl

label define gotwkcom_lbl 0 `"NIU"'
label define gotwkcom_lbl 1 `"No"', add
label define gotwkcom_lbl 2 `"Yes"', add
label values gotwkcom gotwkcom_lbl

label define srcdisa1_lbl 00 `"NIU"'
label define srcdisa1_lbl 01 `"Workers compensation"', add
label define srcdisa1_lbl 02 `"Company or union disability"', add
label define srcdisa1_lbl 03 `"Federal govt disability"', add
label define srcdisa1_lbl 04 `"US military retirement disability"', add
label define srcdisa1_lbl 05 `"State or local govt employee disability"', add
label define srcdisa1_lbl 06 `"US railroad retirement disability"', add
label define srcdisa1_lbl 07 `"Accident or disability insurance"', add
label define srcdisa1_lbl 08 `"Black lung miners disability"', add
label define srcdisa1_lbl 09 `"State temporary sickness"', add
label define srcdisa1_lbl 10 `"Other or don't know"', add
label values srcdisa1 srcdisa1_lbl

label define srcdisa2_lbl 00 `"NIU"'
label define srcdisa2_lbl 01 `"Workers compensation"', add
label define srcdisa2_lbl 02 `"Company or union disability"', add
label define srcdisa2_lbl 03 `"Federal govt disability"', add
label define srcdisa2_lbl 04 `"US military retirement disability"', add
label define srcdisa2_lbl 05 `"State or local govt employee disability"', add
label define srcdisa2_lbl 06 `"US railroad retirement disability"', add
label define srcdisa2_lbl 07 `"Accident or disability insurance"', add
label define srcdisa2_lbl 08 `"Black lung miners disability"', add
label define srcdisa2_lbl 09 `"State temporary sickness"', add
label define srcdisa2_lbl 10 `"Other or don't know"', add
label values srcdisa2 srcdisa2_lbl

label define srcearn_lbl 0 `"NIU"'
label define srcearn_lbl 1 `"Wage and salary"', add
label define srcearn_lbl 2 `"Self employment"', add
label define srcearn_lbl 3 `"Farm self employment"', add
label define srcearn_lbl 4 `"Without pay"', add
label values srcearn srcearn_lbl

label define srceduc_lbl 0 `"NIU"'
label define srceduc_lbl 1 `"Government assistance"', add
label define srceduc_lbl 2 `"Scholarships, grants etc from school"', add
label define srceduc_lbl 3 `"Other assistance"', add
label define srceduc_lbl 4 `"Govt assistance and scholarships, grants etc from school"', add
label define srceduc_lbl 5 `"Govt assistance and other assistance"', add
label define srceduc_lbl 6 `"Scholarships, grants etc from school and other assistance"', add
label define srceduc_lbl 7 `"Govt assistance, scholarships, grants etc from school, and other assistance"', add
label values srceduc srceduc_lbl

label define srcreti1_lbl 0 `"NIU"'
label define srcreti1_lbl 1 `"Company or Union  pension"', add
label define srcreti1_lbl 2 `"Federal Government retirement Pension"', add
label define srcreti1_lbl 3 `"US Military retirement pension"', add
label define srcreti1_lbl 4 `"State or local Govt retirement pension"', add
label define srcreti1_lbl 5 `"US Railroad retirement pension"', add
label define srcreti1_lbl 6 `"Regular payments from annuities or paid-up insurance policies"', add
label define srcreti1_lbl 7 `"Regular payments from IRA, KEOGH, or 401K accounts"', add
label define srcreti1_lbl 8 `"Other or don't know"', add
label values srcreti1 srcreti1_lbl

label define srcreti2_lbl 0 `"NIU"'
label define srcreti2_lbl 1 `"Company or Union  pension"', add
label define srcreti2_lbl 2 `"Federal Government retirement Pension"', add
label define srcreti2_lbl 3 `"US Military retirement pension"', add
label define srcreti2_lbl 4 `"State or local Govt retirement pension"', add
label define srcreti2_lbl 5 `"US Railroad retirement pension"', add
label define srcreti2_lbl 6 `"Regular payments from annuities or paid-up insurance policies"', add
label define srcreti2_lbl 7 `"Regular payments from IRA, KEOGH, or 401K accounts"', add
label define srcreti2_lbl 8 `"Other or do not know"', add
label values srcreti2 srcreti2_lbl

label define srcssi_lbl 0 `"NIU"'
label define srcssi_lbl 1 `"U.S government"', add
label define srcssi_lbl 2 `"State/local government"', add
label define srcssi_lbl 3 `"Both"', add
label values srcssi srcssi_lbl

label define srcsurv1_lbl 00 `"NIU"'
label define srcsurv1_lbl 01 `"Company or union survivor pension"', add
label define srcsurv1_lbl 02 `"Federal government pension"', add
label define srcsurv1_lbl 03 `"US military retirement survivor pension"', add
label define srcsurv1_lbl 04 `"State or local govt survivor pension"', add
label define srcsurv1_lbl 05 `"US railroad retirement survivor pension"', add
label define srcsurv1_lbl 06 `"Workers compensation pension"', add
label define srcsurv1_lbl 07 `"Black lung survivor pension"', add
label define srcsurv1_lbl 08 `"Regular payments from estates or trusts"', add
label define srcsurv1_lbl 09 `"Regular payments from annuities or paid-up life insurance"', add
label define srcsurv1_lbl 10 `"Other or do not know"', add
label values srcsurv1 srcsurv1_lbl

label define srcsurv2_lbl 00 `"NIU"'
label define srcsurv2_lbl 01 `"Company or union survivor pension"', add
label define srcsurv2_lbl 02 `"Federal government pension"', add
label define srcsurv2_lbl 03 `"US military retirement survivor pension"', add
label define srcsurv2_lbl 04 `"State or local govt survivor pension"', add
label define srcsurv2_lbl 05 `"US railroad retirement survivor pension"', add
label define srcsurv2_lbl 06 `"Workers compensation pension"', add
label define srcsurv2_lbl 07 `"Black lung survivor pension"', add
label define srcsurv2_lbl 08 `"Regular payments from estates or trusts"', add
label define srcsurv2_lbl 09 `"Regular payments from annuities or paid-up life insurance"', add
label define srcsurv2_lbl 10 `"Other or do not know"', add
label values srcsurv2 srcsurv2_lbl

label define srcunemp_lbl 0 `"No supplemental or strike benefits"'
label define srcunemp_lbl 1 `"Supplemental unemployment benefits"', add
label define srcunemp_lbl 2 `"Union unemployment or strike benefits"', add
label define srcunemp_lbl 3 `"Both"', add
label define srcunemp_lbl 9 `"NIU"', add
label values srcunemp srcunemp_lbl

label define srcwelfr_lbl 0 `"NIU"'
label define srcwelfr_lbl 1 `"AFDC/TANF"', add
label define srcwelfr_lbl 2 `"Other"', add
label define srcwelfr_lbl 3 `"Both AFDC/TANF and other"', add
label values srcwelfr srcwelfr_lbl

label define srcwkcom_lbl 0 `"NIU"'
label define srcwkcom_lbl 1 `"State Workers Compensation"', add
label define srcwkcom_lbl 2 `"Employer or employers insurance"', add
label define srcwkcom_lbl 3 `"Own insurance"', add
label define srcwkcom_lbl 4 `"Other"', add
label values srcwkcom srcwkcom_lbl

label define ssikid_lbl 0 `"NIU"'
label define ssikid_lbl 1 `"No"', add
label define ssikid_lbl 2 `"Yes"', add
label values ssikid ssikid_lbl

label define sskid_lbl 0 `"NIU"'
label define sskid_lbl 1 `"No"', add
label define sskid_lbl 2 `"Yes"', add
label values sskid sskid_lbl

label define vetqa_lbl 0 `"NIU"'
label define vetqa_lbl 1 `"No"', add
label define vetqa_lbl 2 `"Yes"', add
label values vetqa vetqa_lbl

label define whyss1_lbl 0 `"NIU"'
label define whyss1_lbl 1 `"Retired"', add
label define whyss1_lbl 2 `"Disabled (adult or child)"', add
label define whyss1_lbl 3 `"Widowed"', add
label define whyss1_lbl 4 `"Spouse"', add
label define whyss1_lbl 5 `"Surviving child"', add
label define whyss1_lbl 6 `"Dependent child"', add
label define whyss1_lbl 7 `"On behalf of surviving, dependent, or disabled child(ren)"', add
label define whyss1_lbl 8 `"Other (adult or child)"', add
label values whyss1 whyss1_lbl

label define whyss2_lbl 0 `"NIU"'
label define whyss2_lbl 1 `"Retired"', add
label define whyss2_lbl 2 `"Disabled (adult or child)"', add
label define whyss2_lbl 3 `"Widowed"', add
label define whyss2_lbl 4 `"Spouse"', add
label define whyss2_lbl 5 `"Surviving child"', add
label define whyss2_lbl 6 `"Dependent child"', add
label define whyss2_lbl 7 `"On behalf of surviving, dependent, or disabled child(ren)"', add
label define whyss2_lbl 8 `"Other (adult or child)"', add
label values whyss2 whyss2_lbl

label define whyssi1_lbl 0 `"NIU"'
label define whyssi1_lbl 1 `"Disabled (adult or child)"', add
label define whyssi1_lbl 2 `"Blind (adult or child)"', add
label define whyssi1_lbl 3 `"On behalf of a disabled child"', add
label define whyssi1_lbl 4 `"On behalf of a blind child"', add
label define whyssi1_lbl 5 `"Other (adult or child)"', add
label values whyssi1 whyssi1_lbl

label define whyssi2_lbl 0 `"NIU"'
label define whyssi2_lbl 1 `"Disabled (adult or child)"', add
label define whyssi2_lbl 2 `"Blind (adult or child)"', add
label define whyssi2_lbl 3 `"On behalf of a disabled child"', add
label define whyssi2_lbl 4 `"On behalf of a blind child"', add
label define whyssi2_lbl 5 `"Other (adult or child)"', add
label values whyssi2 whyssi2_lbl

label define gotunemp_lbl 0 `"NIU"'
label define gotunemp_lbl 1 `"No"', add
label define gotunemp_lbl 2 `"Yes"', add
label values gotunemp gotunemp_lbl


