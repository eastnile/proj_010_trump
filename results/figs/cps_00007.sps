* NOTE: You need to edit the `cd` command to specify the path to the directory
* where the data file is located. For example: "C:\ipums_directory".
* .

cd ".".

data list file = "cps_00007.dat" /
  YEAR      1-4
  SERIAL    5-9
  MONTH     10-11
  HWTFINL   12-21 (4)
  CPSID     22-35
  ASECFLAG  36-36
  HFLAG     37-37
  ASECWTH   38-47 (4)
  CPI99     48-51 (3)
  PERNUM    52-53
  WTFINL    54-67 (4)
  CPSIDP    68-81
  ASECWT    82-91 (4)
  FTOTVAL   92-101
  INCTOT    102-109
  INCWAGE   110-116
  INCBUS    117-123
  INCFARM   124-130
  INCUNERN  131-135
  INCSS     136-140
  INCWELFR  141-145
  INCGOV    146-150
  INCIDR    151-155
  INCALOTH  156-160
  INCRETIR  161-166
  INCSSI    167-171
  INCDRT    172-176
  INCINT    177-181
  INCUNEMP  182-186
  INCWKCOM  187-191
  INCVET    192-196
  INCSURV   197-202
  INCDISAB  203-208
  INCDIVID  209-214
  INCRENT   215-219
  INCEDUC   220-224
  INCCHILD  225-229
  INCALIM   230-234
  INCASIST  235-239
  INCOTHER  240-244
  GOTALCH   245-245
  GOTREGCT  246-246
  GOTDIVID  247-247
  GOTELSE   248-248
  GOTESTAT  249-249
  GOTINT    250-250
  GOTSS     251-251
  GOTWELFR  252-252
  GOTFEDRP  253-253
  GOTSTLRP  254-254
  GOTMILRP  255-255
  GOTPVTRP  256-256
  GOTRENT   257-257
  GOTRRRP   258-258
  GOTVDISA  259-259
  GOTVEDUC  260-260
  GOTVETPA  261-261
  GOTVOTHE  262-262
  GOTVPENS  263-263
  GOTVSURV  264-264
  GOTWKCOM  265-265
  INCDISA1  266-270
  INCDISA2  271-275
  INCLONGJ  276-282
  INCRETI1  283-287
  INCRETI2  288-292
  INCSURV1  293-297
  INCSURV2  298-302
  MTHWELFR  303-307
  OINCBUS   308-313
  OINCFARM  314-319
  OINCWAGE  320-326
  SRCDISA1  327-328
  SRCDISA2  329-330
  SRCEARN   331-331
  SRCEDUC   332-332
  SRCRETI1  333-333
  SRCRETI2  334-334
  SRCSSI    335-335
  SRCSURV1  336-337
  SRCSURV2  338-339
  SRCUNEMP  340-340
  SRCWELFR  341-341
  SRCWKCOM  342-342
  SSIKID    343-343
  SSKID     344-344
  VETQA     345-345
  WHYSS1    346-346
  WHYSS2    347-347
  WHYSSI1   348-348
  WHYSSI2   349-349
  GOTUNEMP  350-350
  STIMULUS  351-354
.

variable labels
  YEAR        "Survey year"
  SERIAL      "Household serial number"
  MONTH       "Month"
  HWTFINL     "Household weight, Basic Monthly"
  CPSID       "CPSID, household record"
  ASECFLAG    "Flag for ASEC"
  HFLAG       "Flag for the 3/8 file 2014"
  ASECWTH     "Annual Social and Economic Supplement Household weight"
  CPI99       "CPI-U adjustment factor to 1999 dollars"
  PERNUM      "Person number in sample unit"
  WTFINL      "Final Basic Weight"
  CPSIDP      "CPSID, person record"
  ASECWT      "Annual Social and Economic Supplement Weight"
  FTOTVAL     "Total family income"
  INCTOT      "Total personal income"
  INCWAGE     "Wage and salary income"
  INCBUS      "Non-farm business income"
  INCFARM     "Farm income"
  INCUNERN    "Income from Source other than earnings"
  INCSS       "Social Security income"
  INCWELFR    "Welfare (public assistance) income"
  INCGOV      "Income from other govt programs"
  INCIDR      "Income from interest, dividends, and rent"
  INCALOTH    "Income from alimony, contributions, other"
  INCRETIR    "Retirement income"
  INCSSI      "Income from SSI"
  INCDRT      "Income from dividends, rent, trusts"
  INCINT      "Income from interest"
  INCUNEMP    "Income from unemployment benefits"
  INCWKCOM    "Income from worker's compensation"
  INCVET      "Income from veteran's benefits"
  INCSURV     "Income from survivor's benefits"
  INCDISAB    "Income from disability benefits"
  INCDIVID    "Income from dividends"
  INCRENT     "Income from rent"
  INCEDUC     "Income from educational assistance"
  INCCHILD    "Income from child support"
  INCALIM     "Income from alimony"
  INCASIST    "Income from assistance"
  INCOTHER    "Income from other Source not specified"
  GOTALCH     "Received alimony or child support income"
  GOTREGCT    "Received income from regular contributions"
  GOTDIVID    "Received dividend income"
  GOTELSE     "Received income from anything else not already covered"
  GOTESTAT    "Received estates and trusts income"
  GOTINT      "Received interest income"
  GOTSS       "Received social security"
  GOTWELFR    "Received welfare (public assistance) income"
  GOTFEDRP    "Received federal government pension"
  GOTSTLRP    "Received state and local government pension"
  GOTMILRP    "Received military retirement pension"
  GOTPVTRP    "Received private retirement pension"
  GOTRENT     "Received rental or royalties income"
  GOTRRRP     "Received railroad retirement pension"
  GOTVDISA    "Received veterans' disability compensation"
  GOTVEDUC    "Received veterans' education assistance"
  GOTVETPA    "Received veterans' payments"
  GOTVOTHE    "Received other veterans' payments"
  GOTVPENS    "Received veterans' pension"
  GOTVSURV    "Received veterans' survivor benefits"
  GOTWKCOM    "Received worker's compensation"
  INCDISA1    "Disability income from first source"
  INCDISA2    "Disability income from second source"
  INCLONGJ    "Earnings from longest job"
  INCRETI1    "Retirement income from first source"
  INCRETI2    "Retirement income from second source"
  INCSURV1    "Survivor benefits income from first source"
  INCSURV2    "Survivor benefits income from second source"
  MTHWELFR    "Number of months received welfare income"
  OINCBUS     "Earnings from other work included business self-employment earnings"
  OINCFARM    "Earnings from other work included farm self-employment earnings"
  OINCWAGE    "Earnings from other work included wage and salary earnings"
  SRCDISA1    "First source of disability income"
  SRCDISA2    "Second source of disability income"
  SRCEARN     "Source of earnings from longest job"
  SRCEDUC     "Source of educational assistance"
  SRCRETI1    "First source of retirement income"
  SRCRETI2    "Second source of retirement income"
  SRCSSI      "Source of supplementary security income"
  SRCSURV1    "First source of survivor benefits"
  SRCSURV2    "Second source of survivor benefits"
  SRCUNEMP    "Source of unemployment income"
  SRCWELFR    "Source of welfare income"
  SRCWKCOM    "Source of workmen's compensation"
  SSIKID      "Child under 18 received SSI income"
  SSKID       "Child under 19 received SS income"
  VETQA       "Required to fill out annual income questionnaire for veterans' administration"
  WHYSS1      "First reason for receiving social security income"
  WHYSS2      "Second reason for receiving social security income"
  WHYSSI1     "First reason for receiving supplementary security income"
  WHYSSI2     "Second reason for receiving supplementary security income"
  GOTUNEMP    "Received unemployment compensation"
  STIMULUS    "Federal stimulus payment"
.

value labels
  /MONTH
    01   "January"
    02   "February"
    03   "March"
    04   "April"
    05   "May"
    06   "June"
    07   "July"
    08   "August"
    09   "September"
    10   "October"
    11   "November"
    12   "December"
  /ASECFLAG
    1   "ASEC"
    2   "March Basic"
  /HFLAG
    0   "5/8 file"
    1   "3/8 file"
  /GOTALCH
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTREGCT
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTDIVID
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTELSE
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTESTAT
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTINT
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTSS
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTWELFR
    0   "Blank"
    1   "No"
    2   "Yes"
    9   "NIU"
  /GOTFEDRP
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTSTLRP
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTMILRP
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTPVTRP
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTRENT
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTRRRP
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTVDISA
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTVEDUC
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTVETPA
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTVOTHE
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTVPENS
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTVSURV
    0   "NIU"
    1   "No"
    2   "Yes"
  /GOTWKCOM
    0   "NIU"
    1   "No"
    2   "Yes"
  /SRCDISA1
    00   "NIU"
    01   "Workers compensation"
    02   "Company or union disability"
    03   "Federal govt disability"
    04   "US military retirement disability"
    05   "State or local govt employee disability"
    06   "US railroad retirement disability"
    07   "Accident or disability insurance"
    08   "Black lung miners disability"
    09   "State temporary sickness"
    10   "Other or don't know"
  /SRCDISA2
    00   "NIU"
    01   "Workers compensation"
    02   "Company or union disability"
    03   "Federal govt disability"
    04   "US military retirement disability"
    05   "State or local govt employee disability"
    06   "US railroad retirement disability"
    07   "Accident or disability insurance"
    08   "Black lung miners disability"
    09   "State temporary sickness"
    10   "Other or don't know"
  /SRCEARN
    0   "NIU"
    1   "Wage and salary"
    2   "Self employment"
    3   "Farm self employment"
    4   "Without pay"
  /SRCEDUC
    0   "NIU"
    1   "Government assistance"
    2   "Scholarships, grants etc from school"
    3   "Other assistance"
    4   "Govt assistance and scholarships, grants etc from school"
    5   "Govt assistance and other assistance"
    6   "Scholarships, grants etc from school and other assistance"
    7   "Govt assistance, scholarships, grants etc from school, and other assistance"
  /SRCRETI1
    0   "NIU"
    1   "Company or Union  pension"
    2   "Federal Government retirement Pension"
    3   "US Military retirement pension"
    4   "State or local Govt retirement pension"
    5   "US Railroad retirement pension"
    6   "Regular payments from annuities or paid-up insurance policies"
    7   "Regular payments from IRA, KEOGH, or 401K accounts"
    8   "Other or don't know"
  /SRCRETI2
    0   "NIU"
    1   "Company or Union  pension"
    2   "Federal Government retirement Pension"
    3   "US Military retirement pension"
    4   "State or local Govt retirement pension"
    5   "US Railroad retirement pension"
    6   "Regular payments from annuities or paid-up insurance policies"
    7   "Regular payments from IRA, KEOGH, or 401K accounts"
    8   "Other or do not know"
  /SRCSSI
    0   "NIU"
    1   "U.S government"
    2   "State/local government"
    3   "Both"
  /SRCSURV1
    00   "NIU"
    01   "Company or union survivor pension"
    02   "Federal government pension"
    03   "US military retirement survivor pension"
    04   "State or local govt survivor pension"
    05   "US railroad retirement survivor pension"
    06   "Workers compensation pension"
    07   "Black lung survivor pension"
    08   "Regular payments from estates or trusts"
    09   "Regular payments from annuities or paid-up life insurance"
    10   "Other or do not know"
  /SRCSURV2
    00   "NIU"
    01   "Company or union survivor pension"
    02   "Federal government pension"
    03   "US military retirement survivor pension"
    04   "State or local govt survivor pension"
    05   "US railroad retirement survivor pension"
    06   "Workers compensation pension"
    07   "Black lung survivor pension"
    08   "Regular payments from estates or trusts"
    09   "Regular payments from annuities or paid-up life insurance"
    10   "Other or do not know"
  /SRCUNEMP
    0   "No supplemental or strike benefits"
    1   "Supplemental unemployment benefits"
    2   "Union unemployment or strike benefits"
    3   "Both"
    9   "NIU"
  /SRCWELFR
    0   "NIU"
    1   "AFDC/TANF"
    2   "Other"
    3   "Both AFDC/TANF and other"
  /SRCWKCOM
    0   "NIU"
    1   "State Workers Compensation"
    2   "Employer or employers insurance"
    3   "Own insurance"
    4   "Other"
  /SSIKID
    0   "NIU"
    1   "No"
    2   "Yes"
  /SSKID
    0   "NIU"
    1   "No"
    2   "Yes"
  /VETQA
    0   "NIU"
    1   "No"
    2   "Yes"
  /WHYSS1
    0   "NIU"
    1   "Retired"
    2   "Disabled (adult or child)"
    3   "Widowed"
    4   "Spouse"
    5   "Surviving child"
    6   "Dependent child"
    7   "On behalf of surviving, dependent, or disabled child(ren)"
    8   "Other (adult or child)"
  /WHYSS2
    0   "NIU"
    1   "Retired"
    2   "Disabled (adult or child)"
    3   "Widowed"
    4   "Spouse"
    5   "Surviving child"
    6   "Dependent child"
    7   "On behalf of surviving, dependent, or disabled child(ren)"
    8   "Other (adult or child)"
  /WHYSSI1
    0   "NIU"
    1   "Disabled (adult or child)"
    2   "Blind (adult or child)"
    3   "On behalf of a disabled child"
    4   "On behalf of a blind child"
    5   "Other (adult or child)"
  /WHYSSI2
    0   "NIU"
    1   "Disabled (adult or child)"
    2   "Blind (adult or child)"
    3   "On behalf of a disabled child"
    4   "On behalf of a blind child"
    5   "Other (adult or child)"
  /GOTUNEMP
    0   "NIU"
    1   "No"
    2   "Yes"
.

execute.

