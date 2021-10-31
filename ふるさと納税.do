*2020/11/19
* ふるさと納税データセット

*First, import file "ふるさと納税データ.csv"

xtset no year

*xtline received
*xtline received, overlay

*xtreg prefecturetotalproduction netreceived residentstotalincome laborinputpermonth, fe vce(cluster no)

xtreg productionchange receivedchange deductionchange incomechange laborchange stockchange, fe vce(cluster no)
estimates store fixed

*東京都を除外
*xtreg productionchange receivedchange deductionchange incomechange laborchange if no != 13, fe vce(cluster no)

*xtreg publicchange receivedchange deductionchange incomechange laborchange, fe vce(robust)

*xtreg educchange receivedchange deductionchange incomechange laborchange, fe vce(robust)

*xtreg socialchange receivedchange deductionchange incomechange laborchange, fe vce(robust)

*平成26～29年度のデータを独立してみると、かなり有意的な結果出で来る
xtreg productionchange receivedchange deductionchange incomechange laborchange stockchange if year>=26, fe vce(cluster no)
estimates store fixed_since26

* 変量効果
xtreg productionchange receivedchange deductionchange incomechange laborchange stockchange, re vce(cluster no)
estimates store random

*xtreg productionchange receivedchange deductionchange incomechange laborchange stockchange if no != 13, re vce(cluster no)

*xtreg publicchange receivedchange deductionchange incomechange laborchange, re vce(robust)

*xtreg educchange receivedchange deductionchange incomechange laborchange, re vce(robust)

*xtreg socialchange receivedchange deductionchange incomechange laborchange, re vce(robust)

*hausman test cannot be conducted with robust included fixed random
hausman fixed random

*Pooled OLS
reg productionchange receivedchange deductionchange incomechange laborchange stockchange, robust

reg productionchange receivedchange deductionchange incomechange laborchange stockchange if no != 13, robust

*Check the multicollinearity => if there is any variable with vif greater than 10, it should be worried.
pwcorr productionchange receivedchange deductionchange incomechange laborchange 

stockchange
vif 

est table ...... , b se 