setproj(10)
---
title: "Untitled"
author: "Zhaochen He"
date: "sysdate"
output: html_document
---



## R Markdown



```r
#stargazer(mod$ols$m,type='html',title='OLS with state FEs',report='vcp*')
#stargazer(mod$logit$m,type='html',title='OLS with state FEs',report='vcp*')
#stargazer(mod$probit$m,type='html',title='OLS with state FEs',report='vcp*')
#stargazer(attitude,type='html',title='test')

# stargazer(c(mod$probit$m,mod$probitfe$m),type='html',title='OLS with state FEs',report='vc*sp',covariate.labels=xlabels)



stargazer(c(mod$ols$m), type = 'html', title = 'OLS with state FEs', report = 'vc*sp', covariate.labels = xlabels)
```


<table style="text-align:center"><caption><strong>OLS with state FEs</strong></caption>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="2"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>cc.TrumpGEVote</td><td>cc.TrumpPVote</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Unemployed</td><td>-0.015</td><td>0.020<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.009)</td><td>(0.012)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.102</td><td>p = 0.091</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Expect Leaner Times (higher = more pessmistic)</td><td>0.059<sup>***</sup></td><td>0.002</td></tr>
<tr><td style="text-align:left"></td><td>(0.003)</td><td>(0.003)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.438</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Family Income (higher is more)</td><td>0.002<sup>***</sup></td><td>0.001</td></tr>
<tr><td style="text-align:left"></td><td>(0.001)</td><td>(0.001)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.004</td><td>p = 0.275</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Economic Crash in County</td><td>0.006</td><td>0.023</td></tr>
<tr><td style="text-align:left"></td><td>(0.033)</td><td>(0.041)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.864</td><td>p = 0.574</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Manufacturing Crash in County</td><td>-0.037</td><td>-0.199<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.081)</td><td>(0.100)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.645</td><td>p = 0.046</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Unemp. rate in County</td><td>0.001</td><td>0.003</td></tr>
<tr><td style="text-align:left"></td><td>(0.002)</td><td>(0.002)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.467</td><td>p = 0.147</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Median HI in County</td><td>-0.001<sup>***</sup></td><td>-0.001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.0003)</td><td>(0.0004)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.007</td><td>p = 0.008</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Pct HHs in Poverty in County</td><td>-0.003<sup>*</sup></td><td>-0.005<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.001)</td><td>(0.002)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.062</td><td>p = 0.009</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Pct Workers Filling for TAA in County</td><td>0.948</td><td>-7.801</td></tr>
<tr><td style="text-align:left"></td><td>(5.660)</td><td>(7.072)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.868</td><td>p = 0.270</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Finished School (1=Y,0=N)</td><td>-0.033<sup>***</sup></td><td>-0.005</td></tr>
<tr><td style="text-align:left"></td><td>(0.009)</td><td>(0.011)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0003</td><td>p = 0.639</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Lost Job (1=Y,0=N)</td><td>0.017<sup>**</sup></td><td>0.020<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.007)</td><td>(0.009)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.017</td><td>p = 0.019</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Married (1=Y,0=N)</td><td>-0.008</td><td>-0.018<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.008)</td><td>(0.009)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.316</td><td>p = 0.053</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Start New Job (1=Y,0=N)</td><td>0.020<sup>***</sup></td><td>0.0002</td></tr>
<tr><td style="text-align:left"></td><td>(0.006)</td><td>(0.007)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0004</td><td>p = 0.980</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Divorced (1=Y,0=N)</td><td>0.028<sup>**</sup></td><td>0.003</td></tr>
<tr><td style="text-align:left"></td><td>(0.014)</td><td>(0.018)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.048</td><td>p = 0.849</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Got raise (1=Y,0=N)</td><td>-0.014<sup>***</sup></td><td>-0.021<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.006)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.005</td><td>p = 0.0004</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Had Child (1=Y,0=N)</td><td>0.017<sup>*</sup></td><td>-0.028<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.009)</td><td>(0.011)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.067</td><td>p = 0.013</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Victim of Crime (1=Y,0=N)</td><td>-0.005</td><td>-0.005</td></tr>
<tr><td style="text-align:left"></td><td>(0.010)</td><td>(0.012)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.589</td><td>p = 0.647</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: ER Visit (1=Y,0=N)</td><td>-0.005</td><td>0.0002</td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.006)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.294</td><td>p = 0.975</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">P4Yr: Retired (1=Y,0=N)</td><td>-0.031</td><td>-0.005</td></tr>
<tr><td style="text-align:left"></td><td>(0.019)</td><td>(0.023)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.104</td><td>p = 0.830</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Death rate in County: All of Above</td><td>-0.492<sup>*</sup></td><td>-0.818<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.267)</td><td>(0.332)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.065</td><td>p = 0.014</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Immigration - More border patrols</td><td>0.121<sup>***</sup></td><td>0.047<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.006)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Immigration - No amnesty for dreamers</td><td>0.079<sup>***</sup></td><td>0.063<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.007)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Immigration - Deport Illegals</td><td>0.126<sup>***</sup></td><td>0.118<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.006)</td><td>(0.007)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Immigration - No amnesty even if employed</td><td>0.065<sup>***</sup></td><td>0.035<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.006)</td><td>(0.007)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.00000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Race - Not angry abour racism</td><td>0.033<sup>***</sup></td><td>0.022<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.003)</td><td>(0.003)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Race - Whites don't have advantages</td><td>0.099<sup>***</sup></td><td>0.050<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.002)</td><td>(0.003)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Race - Fearful of other races</td><td>0.005<sup>***</sup></td><td>0.016<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.002)</td><td>(0.002)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.007</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Race - Racism is rare</td><td>0.038<sup>***</sup></td><td>0.004</td></tr>
<tr><td style="text-align:left"></td><td>(0.002)</td><td>(0.003)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.139</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: Trusts Police</td><td>0.035<sup>***</sup></td><td>0.012<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.003)</td><td>(0.004)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.003</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Views: No TPP Trade Deal</td><td>0.063<sup>***</sup></td><td>0.057<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.006)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Church Attendance (higher is more)</td><td>0.024<sup>***</sup></td><td>-0.007<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.001)</td><td>(0.002)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.00002</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Age</td><td>0.001<sup>***</sup></td><td>0.001<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.0002)</td><td>(0.0003)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.002</td><td>p = 0.035</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Sex</td><td>-0.018<sup>***</sup></td><td>0.010<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.006)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0002</td><td>p = 0.093</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Black</td><td>-0.176<sup>***</sup></td><td>-0.074<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.008)</td><td>(0.010)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000</td><td>p = 0.000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">College Graduate</td><td>-0.018<sup>***</sup></td><td>-0.034<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.006)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.001</td><td>p = 0.00000</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Years in Current City</td><td>0.0001</td><td>0.0003</td></tr>
<tr><td style="text-align:left"></td><td>(0.0002)</td><td>(0.0002)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.408</td><td>p = 0.160</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Is an Immigrant</td><td>0.071</td><td>0.111<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.048)</td><td>(0.055)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.141</td><td>p = 0.045</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Separated/Divorced</td><td>0.005</td><td>0.004</td></tr>
<tr><td style="text-align:left"></td><td>(0.008)</td><td>(0.010)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.552</td><td>p = 0.685</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Has childen under 18</td><td>0.002</td><td>0.012<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.006)</td><td>(0.007)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.722</td><td>p = 0.087</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Active Duty</td><td>0.067<sup>***</sup></td><td>0.059<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.022)</td><td>(0.025)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.002</td><td>p = 0.018</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Veteran</td><td>0.029<sup>***</sup></td><td>0.019<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.008)</td><td>(0.010)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0003</td><td>p = 0.047</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">In a union (1=Y,0=N)</td><td>-0.012<sup>**</sup></td><td>-0.016<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.006)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.023</td><td>p = 0.014</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Use Social Media</td><td>0.028<sup>***</sup></td><td>-0.008</td></tr>
<tr><td style="text-align:left"></td><td>(0.005)</td><td>(0.007)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00000</td><td>p = 0.211</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Interest in Politics</td><td>-0.006<sup>*</sup></td><td>-0.006</td></tr>
<tr><td style="text-align:left"></td><td>(0.003)</td><td>(0.004)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.080</td><td>p = 0.177</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Pct Hispanic in County</td><td>-0.0002</td><td>-0.0001</td></tr>
<tr><td style="text-align:left"></td><td>(0.0003)</td><td>(0.0004)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.504</td><td>p = 0.767</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Pct Evangelical in County</td><td>0.073<sup>*</sup></td><td>-0.068</td></tr>
<tr><td style="text-align:left"></td><td>(0.039)</td><td>(0.049)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.061</td><td>p = 0.169</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Population Density</td><td>-0.00000<sup>*</sup></td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>(0.00000)</td><td>(0.00000)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.095</td><td>p = 0.287</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AL</td><td>-0.089</td><td>-0.052</td></tr>
<tr><td style="text-align:left"></td><td>(0.058)</td><td>(0.077)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.128</td><td>p = 0.504</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AK</td><td>-0.064</td><td>-0.041</td></tr>
<tr><td style="text-align:left"></td><td>(0.078)</td><td>(0.105)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.414</td><td>p = 0.700</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AZ</td><td>-0.085</td><td>-0.045</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.121</td><td>p = 0.543</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AR</td><td>-0.109<sup>*</sup></td><td>-0.072</td></tr>
<tr><td style="text-align:left"></td><td>(0.062)</td><td>(0.081)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.081</td><td>p = 0.370</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CA</td><td>-0.163<sup>***</sup></td><td>-0.098</td></tr>
<tr><td style="text-align:left"></td><td>(0.054)</td><td>(0.073)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003</td><td>p = 0.179</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CO</td><td>-0.109<sup>**</sup></td><td>-0.110</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.076)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.049</td><td>p = 0.149</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CT</td><td>-0.080</td><td>-0.064</td></tr>
<tr><td style="text-align:left"></td><td>(0.057)</td><td>(0.078)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.167</td><td>p = 0.411</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DE</td><td>-0.120<sup>*</sup></td><td>-0.199<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.064)</td><td>(0.085)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.060</td><td>p = 0.020</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DC</td><td>-0.192<sup>***</sup></td><td>-0.110</td></tr>
<tr><td style="text-align:left"></td><td>(0.064)</td><td>(0.087)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003</td><td>p = 0.205</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_FL</td><td>-0.132<sup>**</sup></td><td>-0.115</td></tr>
<tr><td style="text-align:left"></td><td>(0.054)</td><td>(0.073)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.015</td><td>p = 0.113</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_GA</td><td>-0.099<sup>*</sup></td><td>-0.082</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.072</td><td>p = 0.269</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_HI</td><td>-0.249<sup>***</sup></td><td>-0.220<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.069)</td><td>(0.091)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0004</td><td>p = 0.016</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ID</td><td>0.009</td><td>-0.147<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.062)</td><td>(0.084)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.890</td><td>p = 0.080</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IL</td><td>-0.136<sup>**</sup></td><td>-0.122<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.073)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.013</td><td>p = 0.096</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IN</td><td>-0.056</td><td>-0.030</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.307</td><td>p = 0.690</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IA</td><td>-0.136<sup>**</sup></td><td>-0.210<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.057)</td><td>(0.078)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.018</td><td>p = 0.008</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KS</td><td>-0.070</td><td>-0.196<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.058)</td><td>(0.080)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.224</td><td>p = 0.015</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KY</td><td>-0.087</td><td>-0.167<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.057)</td><td>(0.077)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.127</td><td>p = 0.030</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_LA</td><td>-0.090</td><td>-0.118</td></tr>
<tr><td style="text-align:left"></td><td>(0.057)</td><td>(0.078)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.117</td><td>p = 0.132</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ME</td><td>-0.087</td><td>-0.116</td></tr>
<tr><td style="text-align:left"></td><td>(0.063)</td><td>(0.087)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.165</td><td>p = 0.180</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MD</td><td>-0.120<sup>**</sup></td><td>-0.140<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.056)</td><td>(0.075)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.032</td><td>p = 0.062</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MA</td><td>-0.169<sup>***</sup></td><td>-0.155<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.056)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003</td><td>p = 0.037</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MI</td><td>-0.106<sup>*</sup></td><td>-0.128<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.056</td><td>p = 0.085</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MN</td><td>-0.166<sup>***</sup></td><td>-0.171<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.077)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003</td><td>p = 0.026</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MS</td><td>-0.098</td><td>-0.020</td></tr>
<tr><td style="text-align:left"></td><td>(0.064)</td><td>(0.084)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.126</td><td>p = 0.810</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MO</td><td>-0.069</td><td>-0.033</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.210</td><td>p = 0.656</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MT</td><td>-0.028</td><td>0.062</td></tr>
<tr><td style="text-align:left"></td><td>(0.067)</td><td>(0.088)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.681</td><td>p = 0.481</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NE</td><td>-0.064</td><td>-0.120</td></tr>
<tr><td style="text-align:left"></td><td>(0.061)</td><td>(0.081)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.291</td><td>p = 0.142</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NV</td><td>-0.085</td><td>-0.136<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.058)</td><td>(0.078)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.140</td><td>p = 0.082</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NH</td><td>-0.149<sup>**</sup></td><td>-0.190<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.059)</td><td>(0.078)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.013</td><td>p = 0.015</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NJ</td><td>-0.128<sup>**</sup></td><td>-0.082</td></tr>
<tr><td style="text-align:left"></td><td>(0.056)</td><td>(0.075)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.022</td><td>p = 0.274</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NM</td><td>-0.112<sup>*</sup></td><td>-0.118</td></tr>
<tr><td style="text-align:left"></td><td>(0.064)</td><td>(0.086)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.082</td><td>p = 0.168</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NY</td><td>-0.118<sup>**</sup></td><td>-0.111</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.031</td><td>p = 0.135</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NC</td><td>-0.116<sup>**</sup></td><td>-0.107</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.035</td><td>p = 0.145</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ND</td><td>-0.088</td><td>-0.251<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.073)</td><td>(0.092)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.227</td><td>p = 0.007</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OH</td><td>-0.116<sup>**</sup></td><td>-0.124<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.054)</td><td>(0.073)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.033</td><td>p = 0.088</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OK</td><td>-0.080</td><td>-0.092</td></tr>
<tr><td style="text-align:left"></td><td>(0.059)</td><td>(0.079)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.179</td><td>p = 0.242</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OR</td><td>-0.114<sup>**</sup></td><td>-0.128<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.056)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.041</td><td>p = 0.085</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_PA</td><td>-0.096<sup>*</sup></td><td>-0.089</td></tr>
<tr><td style="text-align:left"></td><td>(0.054)</td><td>(0.073)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.079</td><td>p = 0.226</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_RI</td><td>-0.149<sup>**</sup></td><td>-0.066</td></tr>
<tr><td style="text-align:left"></td><td>(0.065)</td><td>(0.086)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.023</td><td>p = 0.443</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SC</td><td>-0.065</td><td>-0.096</td></tr>
<tr><td style="text-align:left"></td><td>(0.058)</td><td>(0.077)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.257</td><td>p = 0.210</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SD</td><td>-0.075</td><td>-0.171<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.067)</td><td>(0.091)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.268</td><td>p = 0.062</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TN</td><td>-0.095<sup>*</sup></td><td>-0.067</td></tr>
<tr><td style="text-align:left"></td><td>(0.057)</td><td>(0.076)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.095</td><td>p = 0.374</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TX</td><td>-0.111<sup>**</sup></td><td>-0.149<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.054)</td><td>(0.073)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.041</td><td>p = 0.042</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_UT</td><td>-0.073</td><td>-0.137<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.059)</td><td>(0.079)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.212</td><td>p = 0.082</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VT</td><td>-0.174<sup>**</sup></td><td>-0.191<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.074)</td><td>(0.089)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.019</td><td>p = 0.033</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VA</td><td>-0.119<sup>**</sup></td><td>-0.102</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.030</td><td>p = 0.166</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WA</td><td>-0.114<sup>**</sup></td><td>-0.085</td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.073)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.037</td><td>p = 0.249</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WV</td><td>-0.097</td><td>-0.054</td></tr>
<tr><td style="text-align:left"></td><td>(0.060)</td><td>(0.079)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.109</td><td>p = 0.499</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WI</td><td>-0.116<sup>**</sup></td><td>-0.169<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td>(0.055)</td><td>(0.074)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.036</td><td>p = 0.023</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WY</td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>-0.455<sup>***</sup></td><td>-0.018</td></tr>
<tr><td style="text-align:left"></td><td>(0.082)</td><td>(0.104)</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00000</td><td>p = 0.864</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>20,386</td><td>16,625</td></tr>
<tr><td style="text-align:left">R<sup>2</sup></td><td>0.596</td><td>0.252</td></tr>
<tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.594</td><td>0.247</td></tr>
<tr><td style="text-align:left">Residual Std. Error</td><td>0.316 (df = 20288)</td><td>0.341 (df = 16527)</td></tr>
<tr><td style="text-align:left">F Statistic</td><td>308.787<sup>***</sup> (df = 97; 20288)</td><td>57.271<sup>***</sup> (df = 97; 16527)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="2" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>
