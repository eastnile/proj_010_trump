setproj(10)
---
title: "Untitled"
author: "Zhaochen He"
date: "September 13, 2018"
output: html_document
---



## R Markdown

YO DOOD
WHADUP


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

```r
print(t.text)
```

```
## [1] "hello world"
```

```r
print('yo2')
```

```
## [1] "yo2"
```




```r
stargazer(mod$ols$m,type='html',title='OLS with state FEs',report='vcp*')
```


<table style="text-align:center"><caption><strong>OLS with state FEs</strong></caption>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="2"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>cc.TrumpPVote</td><td>cc.TrumpGEVote</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">cc.CC16_305_5</td><td>-0.011</td><td>-0.013</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.416</td><td>p = 0.206</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_9</td><td>0.003</td><td>-0.009</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.716</td><td>p = 0.247</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_10</td><td>-0.002</td><td>0.005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.581</td><td>p = 0.135</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.drugalc.disc95</td><td>-0.00001</td><td>0.00001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.020<sup>**</sup></td><td>p = 0.118</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.opioid.disc95</td><td>0.00001</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.188</td><td>p = 0.950</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.disc95</td><td>0.00003</td><td>-0.00001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.022<sup>**</sup></td><td>p = 0.333</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.drugalc.disc95.pdpy</td><td>-0.303</td><td>-0.916</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.613</td><td>p = 0.051<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.opioid.8.pdpy</td><td>-0.006</td><td>0.790</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.996</td><td>p = 0.345</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.12.pdpy</td><td>-2.218</td><td>-0.555</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.166</td><td>p = 0.651</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.disc95.pdpy</td><td>3.228</td><td>1.372</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.130</td><td>p = 0.402</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_religimp</td><td>-0.012</td><td>-0.026</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0001<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_churatd</td><td>0.013</td><td>-0.013</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_prayer</td><td>-0.001</td><td>-0.005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.568</td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">relig.evan.pc</td><td>-0.013</td><td>0.066</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.733</td><td>p = 0.023<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422c</td><td>0.025</td><td>0.044</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422d</td><td>0.053</td><td>0.094</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422e</td><td>-0.018</td><td>-0.011</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422f</td><td>0.001</td><td>-0.038</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.728</td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_2</td><td>-0.056</td><td>-0.130</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_3</td><td>0.058</td><td>0.098</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_7</td><td>-0.120</td><td>-0.151</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_2</td><td>-0.006</td><td>-0.013</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.379</td><td>p = 0.012<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_7</td><td>-0.002</td><td>-0.011</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.733</td><td>p = 0.015<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_11</td><td>0.017</td><td>0.017</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.002<sup>***</sup></td><td>p = 0.00004<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_351B</td><td>0.053</td><td>0.071</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.employ</td><td>0.0003</td><td>-0.002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.761</td><td>p = 0.008<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.ownhome</td><td>-0.013</td><td>-0.014</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003<sup>***</sup></td><td>p = 0.00003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl</td><td>0.00000</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.578</td><td>p = 0.332</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl.w</td><td>0.00000</td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.943</td><td>p = 0.223</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl.w.sharp</td><td>0.00000</td><td>0.00001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.963</td><td>p = 0.500</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc</td><td>0.017</td><td>-0.0003</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.815</td><td>p = 0.997</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc.w</td><td>0.210</td><td>0.167</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.437</td><td>p = 0.440</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc.w.sharp</td><td>-1.076</td><td>-0.662</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.163</td><td>p = 0.296</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashallppl</td><td>-0.00000</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.307</td><td>p = 0.896</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashallpct</td><td>0.025</td><td>-0.016</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.670</td><td>p = 0.725</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustppl</td><td>-0.00000</td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.614</td><td>p = 0.374</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustpct</td><td>-0.028</td><td>-0.014</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.209</td><td>p = 0.424</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustpc</td><td>-0.163</td><td>-0.063</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.111</td><td>p = 0.432</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">job.uer</td><td>0.001</td><td>0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.709</td><td>p = 0.691</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">econ.mhi</td><td>0.00000</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.158</td><td>p = 0.815</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">econ.hhpov.p</td><td>0.002</td><td>0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.160</td><td>p = 0.366</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">taa.wrks.disc95.pcpy</td><td>-0.819</td><td>2.125</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.873</td><td>p = 0.598</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_307</td><td>-0.014</td><td>-0.035</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00001<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.citylength_1</td><td>0.0002</td><td>-0.0001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.142</td><td>p = 0.373</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.unionhh</td><td>0.007</td><td>0.011</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.028<sup>**</sup></td><td>p = 0.0001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Age</td><td>0.001</td><td>-0.00004</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00001<sup>***</sup></td><td>p = 0.815</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Sex</td><td>0.008</td><td>-0.023</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.079<sup>*</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.educ</td><td>-0.017</td><td>-0.007</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.BlackDum</td><td>-0.068</td><td>-0.179</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.UnionMem</td><td>0.008</td><td>0.006</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.482</td><td>p = 0.559</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Catholic</td><td>0.014</td><td>-0.017</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.007<sup>***</sup></td><td>p = 0.00003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.marstat</td><td>-0.002</td><td>-0.008</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.247</td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_300_5</td><td>-0.0002</td><td>-0.010</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.964</td><td>p = 0.004<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_304</td><td>0.008</td><td>0.030</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_1</td><td>-0.006</td><td>0.019</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.448</td><td>p = 0.003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_3</td><td>-0.023</td><td>-0.013</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.011<sup>**</sup></td><td>p = 0.073<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_4</td><td>-0.001</td><td>0.024</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.831</td><td>p = 0.00002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_6</td><td>0.013</td><td>-0.013</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.177</td><td>p = 0.082<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.child18</td><td>-0.002</td><td>0.004</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.713</td><td>p = 0.428</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.immstat</td><td>-0.0002</td><td>0.006</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.937</td><td>p = 0.0002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.milstat_1</td><td>-0.016</td><td>-0.053</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.500</td><td>p = 0.016<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.milstat_3</td><td>-0.027</td><td>-0.029</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00003<sup>***</sup></td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.union</td><td>0.015</td><td>0.019</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.007<sup>***</sup></td><td>p = 0.00001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.newsint</td><td>-0.002</td><td>0.0002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.423</td><td>p = 0.910</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">sex.f.clf.p</td><td>-0.002</td><td>-0.0005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.007<sup>***</sup></td><td>p = 0.454</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.black.p</td><td>-0.001</td><td>-0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.133</td><td>p = 0.00001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.na.p</td><td>-0.001</td><td>0.0003</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.583</td><td>p = 0.765</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.asian.p</td><td>-0.001</td><td>-0.002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.210</td><td>p = 0.002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.pacific.p</td><td>0.013</td><td>-0.012</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.374</td><td>p = 0.323</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.other.p</td><td>0.001</td><td>-0.0005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.413</td><td>p = 0.557</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.2plus.p</td><td>-0.00004</td><td>-0.002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.989</td><td>p = 0.392</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">eth.his.p</td><td>-0.0002</td><td>-0.0004</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.628</td><td>p = 0.198</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">demo.popdense</td><td>-0.00000</td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.069<sup>*</sup></td><td>p = 0.518</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AL</td><td>-0.071</td><td>0.061</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.235</td><td>p = 0.180</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AK</td><td>-0.145</td><td>0.096</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.076<sup>*</sup></td><td>p = 0.108</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AZ</td><td>-0.082</td><td>0.047</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.160</td><td>p = 0.286</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AR</td><td>-0.131</td><td>0.011</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.030<sup>**</sup></td><td>p = 0.815</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CA</td><td>-0.088</td><td>0.061</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.131</td><td>p = 0.165</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CO</td><td>-0.104</td><td>0.040</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.076<sup>*</sup></td><td>p = 0.347</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CT</td><td>-0.059</td><td>0.052</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.338</td><td>p = 0.262</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DE</td><td>-0.094</td><td>0.027</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.152</td><td>p = 0.576</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DC</td><td>-0.048</td><td>0.060</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.504</td><td>p = 0.270</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_FL</td><td>-0.101</td><td>0.042</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.076<sup>*</sup></td><td>p = 0.324</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_GA</td><td>-0.092</td><td>0.082</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.108</td><td>p = 0.059<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_HI</td><td>-0.224</td><td>0.249</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.142</td><td>p = 0.040<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ID</td><td>-0.165</td><td>0.074</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.008<sup>***</sup></td><td>p = 0.118</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IL</td><td>-0.118</td><td>0.022</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.042<sup>**</sup></td><td>p = 0.614</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IN</td><td>-0.072</td><td>0.043</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.213</td><td>p = 0.324</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IA</td><td>-0.198</td><td>-0.006</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.002<sup>***</sup></td><td>p = 0.901</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KS</td><td>-0.169</td><td>0.028</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.007<sup>***</sup></td><td>p = 0.540</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KY</td><td>-0.173</td><td>0.017</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.004<sup>***</sup></td><td>p = 0.701</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_LA</td><td>-0.055</td><td>0.092</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.359</td><td>p = 0.043<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ME</td><td>-0.113</td><td>0.012</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.094<sup>*</sup></td><td>p = 0.807</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MD</td><td>-0.085</td><td>0.081</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.149</td><td>p = 0.069<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MA</td><td>-0.111</td><td>0.011</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.068<sup>*</sup></td><td>p = 0.814</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MI</td><td>-0.134</td><td>0.018</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.021<sup>**</sup></td><td>p = 0.684</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MN</td><td>-0.133</td><td>0.027</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.025<sup>**</sup></td><td>p = 0.532</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MS</td><td>-0.066</td><td>0.020</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.301</td><td>p = 0.681</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MO</td><td>-0.096</td><td>0.033</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.094<sup>*</sup></td><td>p = 0.447</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MT</td><td>0.004</td><td>0.058</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.950</td><td>p = 0.244</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NE</td><td>-0.068</td><td>0.063</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.281</td><td>p = 0.180</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NV</td><td>-0.175</td><td>0.044</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.004<sup>***</sup></td><td>p = 0.338</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NH</td><td>-0.147</td><td>0.009</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.017<sup>**</sup></td><td>p = 0.856</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NJ</td><td>-0.041</td><td>0.068</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.491</td><td>p = 0.132</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NM</td><td>-0.135</td><td>0.057</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.031<sup>**</sup></td><td>p = 0.226</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NY</td><td>-0.061</td><td>0.074</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.302</td><td>p = 0.097<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NC</td><td>-0.114</td><td>0.040</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.047<sup>**</sup></td><td>p = 0.356</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ND</td><td>-0.055</td><td>0.011</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.475</td><td>p = 0.845</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OH</td><td>-0.121</td><td>0.015</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.037<sup>**</sup></td><td>p = 0.736</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OK</td><td>-0.155</td><td>0.035</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.013<sup>**</sup></td><td>p = 0.464</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OR</td><td>-0.079</td><td>0.044</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.171</td><td>p = 0.319</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_PA</td><td>-0.073</td><td>0.046</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.205</td><td>p = 0.287</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_RI</td><td>-0.013</td><td>0.045</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.843</td><td>p = 0.385</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SC</td><td>-0.096</td><td>0.096</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.102</td><td>p = 0.032<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SD</td><td>-0.074</td><td>0.056</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.293</td><td>p = 0.280</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TN</td><td>-0.078</td><td>0.024</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.180</td><td>p = 0.580</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TX</td><td>-0.185</td><td>0.049</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.002<sup>***</sup></td><td>p = 0.248</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_UT</td><td>-0.188</td><td>0.085</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003<sup>***</sup></td><td>p = 0.071<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VT</td><td>-0.139</td><td>0.024</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.045<sup>**</sup></td><td>p = 0.667</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VA</td><td>-0.122</td><td>0.043</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.032<sup>**</sup></td><td>p = 0.320</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WA</td><td>-0.096</td><td>0.052</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.096<sup>*</sup></td><td>p = 0.238</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WV</td><td>-0.082</td><td>0.041</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.183</td><td>p = 0.376</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WI</td><td>-0.128</td><td>0.032</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.027<sup>**</sup></td><td>p = 0.467</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WY</td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>0.474</td><td>0.760</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00001<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>31,374</td><td>38,926</td></tr>
<tr><td style="text-align:left">R<sup>2</sup></td><td>0.262</td><td>0.609</td></tr>
<tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.259</td><td>0.607</td></tr>
<tr><td style="text-align:left">Residual Std. Error</td><td>0.354 (df = 31250)</td><td>0.312 (df = 38802)</td></tr>
<tr><td style="text-align:left">F Statistic</td><td>90.203<sup>***</sup> (df = 123; 31250)</td><td>490.732<sup>***</sup> (df = 123; 38802)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="2" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>

```r
stargazer(mod$logit$m,type='html',title='OLS with state FEs',report='vcp*')
```


<table style="text-align:center"><caption><strong>OLS with state FEs</strong></caption>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="2"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>cc.TrumpPVote</td><td>cc.TrumpGEVote</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">cc.CC16_305_5</td><td>-0.178</td><td>-0.186</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.115</td><td>p = 0.098<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_9</td><td>0.017</td><td>-0.210</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.818</td><td>p = 0.013<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_10</td><td>-0.042</td><td>0.052</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.231</td><td>p = 0.163</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.drugalc.disc95</td><td>-0.0001</td><td>0.0001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.042<sup>**</sup></td><td>p = 0.248</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.opioid.disc95</td><td>0.0001</td><td>-0.00001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.244</td><td>p = 0.894</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.disc95</td><td>0.0002</td><td>-0.0001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.026<sup>**</sup></td><td>p = 0.408</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.drugalc.disc95.pdpy</td><td>-4.426</td><td>-8.957</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.356</td><td>p = 0.082<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.opioid.8.pdpy</td><td>1.161</td><td>11.255</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.893</td><td>p = 0.220</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.12.pdpy</td><td>-13.769</td><td>-13.513</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.263</td><td>p = 0.317</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.disc95.pdpy</td><td>19.501</td><td>28.744</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.237</td><td>p = 0.112</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_religimp</td><td>-0.110</td><td>-0.276</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00003<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_churatd</td><td>0.094</td><td>-0.134</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_prayer</td><td>-0.012</td><td>-0.056</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.258</td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">relig.evan.pc</td><td>-0.022</td><td>0.879</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.939</td><td>p = 0.006<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422c</td><td>0.126</td><td>0.476</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422d</td><td>0.346</td><td>0.670</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422e</td><td>-0.161</td><td>-0.084</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422f</td><td>-0.044</td><td>-0.386</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_2</td><td>-0.575</td><td>-1.037</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_3</td><td>0.538</td><td>0.816</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_7</td><td>-0.802</td><td>-1.032</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_2</td><td>-0.080</td><td>-0.195</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.154</td><td>p = 0.002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_7</td><td>0.073</td><td>-0.083</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.157</td><td>p = 0.108</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_11</td><td>0.175</td><td>0.189</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0002<sup>***</sup></td><td>p = 0.00004<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_351B</td><td>0.332</td><td>0.612</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.employ</td><td>-0.006</td><td>-0.033</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.511</td><td>p = 0.0004<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.ownhome</td><td>-0.126</td><td>-0.178</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.001<sup>***</sup></td><td>p = 0.00001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl</td><td>-0.00000</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.855</td><td>p = 0.236</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl.w</td><td>0.00001</td><td>-0.00001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.429</td><td>p = 0.214</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl.w.sharp</td><td>-0.0001</td><td>0.0001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.454</td><td>p = 0.496</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc</td><td>-0.054</td><td>0.028</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.925</td><td>p = 0.965</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc.w</td><td>1.729</td><td>0.963</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.399</td><td>p = 0.661</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc.w.sharp</td><td>-6.756</td><td>-6.652</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.253</td><td>p = 0.243</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashallppl</td><td>-0.00000</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.274</td><td>p = 0.950</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashallpct</td><td>0.373</td><td>-0.178</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.401</td><td>p = 0.724</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustppl</td><td>-0.00000</td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.698</td><td>p = 0.446</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustpct</td><td>-0.182</td><td>-0.209</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.292</td><td>p = 0.275</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustpc</td><td>-1.169</td><td>-0.526</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.133</td><td>p = 0.545</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">job.uer</td><td>0.003</td><td>0.017</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.857</td><td>p = 0.321</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">econ.mhi</td><td>0.00001</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.039<sup>**</sup></td><td>p = 0.304</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">econ.hhpov.p</td><td>0.021</td><td>0.008</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.074<sup>*</sup></td><td>p = 0.534</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">taa.wrks.disc95.pcpy</td><td>-4.471</td><td>33.765</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.909</td><td>p = 0.442</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_307</td><td>-0.170</td><td>-0.423</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.citylength_1</td><td>0.002</td><td>-0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.070<sup>*</sup></td><td>p = 0.270</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.unionhh</td><td>0.073</td><td>0.130</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.011<sup>**</sup></td><td>p = 0.00002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Age</td><td>0.008</td><td>-0.003</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00001<sup>***</sup></td><td>p = 0.082<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Sex</td><td>0.039</td><td>-0.283</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.321</td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.educ</td><td>-0.157</td><td>-0.076</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.BlackDum</td><td>-1.506</td><td>-1.869</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.UnionMem</td><td>0.065</td><td>0.061</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.515</td><td>p = 0.573</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Catholic</td><td>0.147</td><td>-0.152</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0003<sup>***</sup></td><td>p = 0.0003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.marstat</td><td>-0.009</td><td>-0.070</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.448</td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_300_5</td><td>0.026</td><td>-0.089</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.467</td><td>p = 0.024<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_304</td><td>0.048</td><td>0.312</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0002<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_1</td><td>-0.049</td><td>0.166</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.500</td><td>p = 0.018<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_3</td><td>-0.084</td><td>-0.075</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.394</td><td>p = 0.376</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_4</td><td>-0.033</td><td>0.251</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.541</td><td>p = 0.00003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_6</td><td>0.108</td><td>-0.069</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.217</td><td>p = 0.387</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.child18</td><td>-0.112</td><td>0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.025<sup>**</sup></td><td>p = 0.981</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.immstat</td><td>-0.019</td><td>0.037</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.289</td><td>p = 0.028<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.milstat_1</td><td>-0.194</td><td>-0.435</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.322</td><td>p = 0.029<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.milstat_3</td><td>-0.180</td><td>-0.341</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0002<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.union</td><td>0.145</td><td>0.221</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.001<sup>***</sup></td><td>p = 0.00001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.newsint</td><td>0.071</td><td>0.005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0004<sup>***</sup></td><td>p = 0.805</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">sex.f.clf.p</td><td>-0.017</td><td>-0.009</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.008<sup>***</sup></td><td>p = 0.194</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.black.p</td><td>-0.005</td><td>-0.012</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.122</td><td>p = 0.0003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.na.p</td><td>-0.003</td><td>0.006</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.706</td><td>p = 0.593</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.asian.p</td><td>-0.012</td><td>-0.022</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.069<sup>*</sup></td><td>p = 0.001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.pacific.p</td><td>0.141</td><td>-0.150</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.238</td><td>p = 0.255</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.other.p</td><td>0.010</td><td>-0.005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.283</td><td>p = 0.607</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.2plus.p</td><td>0.006</td><td>-0.026</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.793</td><td>p = 0.337</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">eth.his.p</td><td>-0.002</td><td>-0.003</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.553</td><td>p = 0.408</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">demo.popdense</td><td>-0.00001</td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.038<sup>**</sup></td><td>p = 0.457</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AL</td><td>-0.482</td><td>0.503</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.290</td><td>p = 0.350</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AK</td><td>-0.855</td><td>0.857</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.172</td><td>p = 0.234</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AZ</td><td>-0.506</td><td>0.376</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.253</td><td>p = 0.464</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AR</td><td>-0.896</td><td>-0.077</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.053<sup>*</sup></td><td>p = 0.887</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CA</td><td>-0.470</td><td>0.581</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.290</td><td>p = 0.259</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CO</td><td>-0.641</td><td>0.382</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.155</td><td>p = 0.446</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CT</td><td>-0.311</td><td>0.552</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.512</td><td>p = 0.302</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DE</td><td>-0.574</td><td>0.269</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.275</td><td>p = 0.636</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DC</td><td>-0.974</td><td>0.256</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.274</td><td>p = 0.727</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_FL</td><td>-0.607</td><td>0.307</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.162</td><td>p = 0.542</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_GA</td><td>-0.617</td><td>0.682</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.159</td><td>p = 0.181</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_HI</td><td>-1.713</td><td>3.159</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.160</td><td>p = 0.019<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ID</td><td>-1.046</td><td>0.898</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.026<sup>**</sup></td><td>p = 0.100<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IL</td><td>-0.766</td><td>0.130</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.085<sup>*</sup></td><td>p = 0.801</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IN</td><td>-0.425</td><td>0.312</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.333</td><td>p = 0.540</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IA</td><td>-1.596</td><td>-0.089</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.001<sup>***</sup></td><td>p = 0.866</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KS</td><td>-1.343</td><td>0.345</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.006<sup>***</sup></td><td>p = 0.517</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KY</td><td>-1.223</td><td>-0.004</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.007<sup>***</sup></td><td>p = 0.995</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_LA</td><td>-0.465</td><td>0.996</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.311</td><td>p = 0.061<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ME</td><td>-0.644</td><td>0.183</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.225</td><td>p = 0.740</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MD</td><td>-0.580</td><td>0.746</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.202</td><td>p = 0.153</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MA</td><td>-0.770</td><td>0.104</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.100<sup>*</sup></td><td>p = 0.847</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MI</td><td>-0.883</td><td>0.105</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.046<sup>**</sup></td><td>p = 0.837</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MN</td><td>-1.034</td><td>0.116</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.026<sup>**</sup></td><td>p = 0.822</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MS</td><td>-0.407</td><td>0.405</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.403</td><td>p = 0.483</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MO</td><td>-0.616</td><td>0.243</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.161</td><td>p = 0.635</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MT</td><td>0.052</td><td>0.556</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.914</td><td>p = 0.331</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NE</td><td>-0.414</td><td>0.504</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.386</td><td>p = 0.353</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NV</td><td>-1.119</td><td>0.351</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.017<sup>**</sup></td><td>p = 0.507</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NH</td><td>-0.988</td><td>0.005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.041<sup>**</sup></td><td>p = 0.993</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NJ</td><td>-0.198</td><td>0.638</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.663</td><td>p = 0.223</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NM</td><td>-0.799</td><td>0.478</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.100<sup>*</sup></td><td>p = 0.385</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NY</td><td>-0.344</td><td>0.753</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.444</td><td>p = 0.144</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NC</td><td>-0.783</td><td>0.273</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.076<sup>*</sup></td><td>p = 0.592</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ND</td><td>-0.369</td><td>-0.009</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.530</td><td>p = 0.989</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OH</td><td>-0.773</td><td>0.073</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.080<sup>*</sup></td><td>p = 0.886</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OK</td><td>-1.102</td><td>0.217</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.022<sup>**</sup></td><td>p = 0.691</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OR</td><td>-0.424</td><td>0.242</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.337</td><td>p = 0.638</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_PA</td><td>-0.442</td><td>0.412</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.312</td><td>p = 0.416</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_RI</td><td>0.026</td><td>0.421</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.961</td><td>p = 0.470</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SC</td><td>-0.591</td><td>0.922</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.189</td><td>p = 0.078<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SD</td><td>-0.351</td><td>0.390</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.507</td><td>p = 0.506</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TN</td><td>-0.506</td><td>0.036</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.254</td><td>p = 0.944</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TX</td><td>-1.322</td><td>0.446</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003<sup>***</sup></td><td>p = 0.373</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_UT</td><td>-1.242</td><td>0.671</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.009<sup>***</sup></td><td>p = 0.218</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VT</td><td>-0.925</td><td>0.210</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.116</td><td>p = 0.741</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VA</td><td>-0.894</td><td>0.280</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.041<sup>**</sup></td><td>p = 0.579</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WA</td><td>-0.560</td><td>0.471</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.205</td><td>p = 0.359</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WV</td><td>-0.580</td><td>0.352</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.212</td><td>p = 0.515</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WI</td><td>-0.819</td><td>0.263</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.064<sup>*</sup></td><td>p = 0.605</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WY</td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>0.682</td><td>2.973</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.426</td><td>p = 0.002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>31,374</td><td>38,926</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-11,701.660</td><td>-10,915.450</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>23,651.330</td><td>22,078.900</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="2" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>

```r
stargazer(mod$probit$m,type='html',title='OLS with state FEs',report='vcp*')
```


<table style="text-align:center"><caption><strong>OLS with state FEs</strong></caption>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="2"><em>Dependent variable:</em></td></tr>
<tr><td></td><td colspan="2" style="border-bottom: 1px solid black"></td></tr>
<tr><td style="text-align:left"></td><td>cc.TrumpPVote</td><td>cc.TrumpGEVote</td></tr>
<tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">cc.CC16_305_5</td><td>-0.092</td><td>-0.091</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.153</td><td>p = 0.142</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_9</td><td>0.012</td><td>-0.105</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.786</td><td>p = 0.023<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_10</td><td>-0.018</td><td>0.034</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.362</td><td>p = 0.101</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.drugalc.disc95</td><td>-0.0001</td><td>0.00003</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.021<sup>**</sup></td><td>p = 0.281</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.opioid.disc95</td><td>0.0001</td><td>-0.00001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.218</td><td>p = 0.889</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.disc95</td><td>0.0001</td><td>-0.00004</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.016<sup>**</sup></td><td>p = 0.421</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.drugalc.disc95.pdpy</td><td>-2.298</td><td>-5.285</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.406</td><td>p = 0.060<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.opioid.8.pdpy</td><td>0.443</td><td>6.806</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.929</td><td>p = 0.175</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.12.pdpy</td><td>-7.332</td><td>-6.612</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.304</td><td>p = 0.370</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">mort.ucd.suicide.disc95.pdpy</td><td>10.742</td><td>14.630</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.261</td><td>p = 0.139</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_religimp</td><td>-0.061</td><td>-0.150</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00004<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_churatd</td><td>0.051</td><td>-0.074</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.pew_prayer</td><td>-0.007</td><td>-0.031</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.251</td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">relig.evan.pc</td><td>-0.033</td><td>0.498</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.842</td><td>p = 0.005<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422c</td><td>0.078</td><td>0.254</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422d</td><td>0.201</td><td>0.375</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422e</td><td>-0.092</td><td>-0.048</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_422f</td><td>-0.026</td><td>-0.211</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.003<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_2</td><td>-0.320</td><td>-0.579</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_3</td><td>0.297</td><td>0.455</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_331_7</td><td>-0.460</td><td>-0.579</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_2</td><td>-0.046</td><td>-0.106</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.152</td><td>p = 0.002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_7</td><td>0.038</td><td>-0.045</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.193</td><td>p = 0.107</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_11</td><td>0.102</td><td>0.108</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0001<sup>***</sup></td><td>p = 0.00002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_351B</td><td>0.184</td><td>0.340</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.employ</td><td>-0.004</td><td>-0.018</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.456</td><td>p = 0.0004<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.ownhome</td><td>-0.074</td><td>-0.098</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.001<sup>***</sup></td><td>p = 0.00001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl</td><td>0.00000</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.922</td><td>p = 0.188</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl.w</td><td>0.00000</td><td>-0.00001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.490</td><td>p = 0.166</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashppl.w.sharp</td><td>-0.00004</td><td>0.00004</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.455</td><td>p = 0.469</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc</td><td>-0.073</td><td>-0.061</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.824</td><td>p = 0.860</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc.w</td><td>1.106</td><td>0.833</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.348</td><td>p = 0.490</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashpc.w.sharp</td><td>-4.122</td><td>-4.264</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.216</td><td>p = 0.170</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashallppl</td><td>-0.00000</td><td>0.000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.213</td><td>p = 0.996</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">crashallpct</td><td>0.252</td><td>-0.069</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.328</td><td>p = 0.803</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustppl</td><td>-0.00000</td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.587</td><td>p = 0.447</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustpct</td><td>-0.111</td><td>-0.086</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.266</td><td>p = 0.412</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">rustpc</td><td>-0.674</td><td>-0.347</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.137</td><td>p = 0.465</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">job.uer</td><td>0.003</td><td>0.010</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.730</td><td>p = 0.292</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">econ.mhi</td><td>0.00000</td><td>0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.052<sup>*</sup></td><td>p = 0.317</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">econ.hhpov.p</td><td>0.011</td><td>0.004</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.103</td><td>p = 0.609</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">taa.wrks.disc95.pcpy</td><td>2.439</td><td>18.707</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.915</td><td>p = 0.437</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_307</td><td>-0.093</td><td>-0.227</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.citylength_1</td><td>0.001</td><td>-0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.090<sup>*</sup></td><td>p = 0.206</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.unionhh</td><td>0.036</td><td>0.069</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.025<sup>**</sup></td><td>p = 0.00003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Age</td><td>0.004</td><td>-0.002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00001<sup>***</sup></td><td>p = 0.057<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Sex</td><td>0.007</td><td>-0.169</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.739</td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.educ</td><td>-0.088</td><td>-0.042</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.00000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.BlackDum</td><td>-0.714</td><td>-0.958</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.000<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.UnionMem</td><td>0.044</td><td>0.044</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.439</td><td>p = 0.463</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.Catholic</td><td>0.083</td><td>-0.078</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0004<sup>***</sup></td><td>p = 0.001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.marstat</td><td>-0.005</td><td>-0.039</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.406</td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_300_5</td><td>0.016</td><td>-0.053</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.428</td><td>p = 0.013<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_304</td><td>0.030</td><td>0.173</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.00003<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_1</td><td>-0.030</td><td>0.104</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.461</td><td>p = 0.007<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_3</td><td>-0.052</td><td>-0.037</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.331</td><td>p = 0.423</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_4</td><td>-0.010</td><td>0.143</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.745</td><td>p = 0.00002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.CC16_305_6</td><td>0.077</td><td>-0.041</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.115</td><td>p = 0.360</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.child18</td><td>-0.064</td><td>-0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.024<sup>**</sup></td><td>p = 0.976</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.immstat</td><td>-0.011</td><td>0.018</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.266</td><td>p = 0.059<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.milstat_1</td><td>-0.116</td><td>-0.239</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.286</td><td>p = 0.035<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.milstat_3</td><td>-0.105</td><td>-0.189</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.0002<sup>***</sup></td><td>p = 0.000<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.union</td><td>0.083</td><td>0.128</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.001<sup>***</sup></td><td>p = 0.00001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">cc.newsint</td><td>0.038</td><td>0.002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.001<sup>***</sup></td><td>p = 0.843</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">sex.f.clf.p</td><td>-0.010</td><td>-0.005</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.008<sup>***</sup></td><td>p = 0.175</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.black.p</td><td>-0.003</td><td>-0.007</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.112</td><td>p = 0.0003<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.na.p</td><td>-0.002</td><td>0.002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.700</td><td>p = 0.696</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.asian.p</td><td>-0.007</td><td>-0.012</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.057<sup>*</sup></td><td>p = 0.001<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.pacific.p</td><td>0.075</td><td>-0.069</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.270</td><td>p = 0.336</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.other.p</td><td>0.006</td><td>-0.001</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.228</td><td>p = 0.872</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">race.2plus.p</td><td>0.005</td><td>-0.012</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.720</td><td>p = 0.418</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">eth.his.p</td><td>-0.001</td><td>-0.002</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.484</td><td>p = 0.426</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">demo.popdense</td><td>-0.00001</td><td>-0.00000</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.055<sup>*</sup></td><td>p = 0.474</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AL</td><td>-0.253</td><td>0.236</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.331</td><td>p = 0.416</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AK</td><td>-0.510</td><td>0.484</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.158</td><td>p = 0.214</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AZ</td><td>-0.276</td><td>0.206</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.274</td><td>p = 0.459</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_AR</td><td>-0.494</td><td>-0.082</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.061<sup>*</sup></td><td>p = 0.780</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CA</td><td>-0.265</td><td>0.302</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.295</td><td>p = 0.278</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CO</td><td>-0.336</td><td>0.201</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.191</td><td>p = 0.459</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_CT</td><td>-0.175</td><td>0.302</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.517</td><td>p = 0.298</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DE</td><td>-0.326</td><td>0.128</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.275</td><td>p = 0.676</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_DC</td><td>-0.420</td><td>0.106</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.348</td><td>p = 0.783</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_FL</td><td>-0.332</td><td>0.150</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.178</td><td>p = 0.582</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_GA</td><td>-0.333</td><td>0.354</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.182</td><td>p = 0.199</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_HI</td><td>-0.931</td><td>1.570</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.181</td><td>p = 0.033<sup>**</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ID</td><td>-0.561</td><td>0.497</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.037<sup>**</sup></td><td>p = 0.093<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IL</td><td>-0.411</td><td>0.061</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.104</td><td>p = 0.827</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IN</td><td>-0.224</td><td>0.154</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.370</td><td>p = 0.577</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_IA</td><td>-0.890</td><td>-0.060</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.002<sup>***</sup></td><td>p = 0.833</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KS</td><td>-0.735</td><td>0.182</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.009<sup>***</sup></td><td>p = 0.528</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_KY</td><td>-0.674</td><td>-0.017</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.009<sup>***</sup></td><td>p = 0.954</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_LA</td><td>-0.207</td><td>0.548</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.429</td><td>p = 0.057<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ME</td><td>-0.348</td><td>0.080</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.251</td><td>p = 0.788</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MD</td><td>-0.313</td><td>0.392</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.226</td><td>p = 0.165</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MA</td><td>-0.429</td><td>0.031</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.107</td><td>p = 0.916</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MI</td><td>-0.485</td><td>0.050</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.054<sup>*</sup></td><td>p = 0.856</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MN</td><td>-0.577</td><td>0.040</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.029<sup>**</sup></td><td>p = 0.886</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MS</td><td>-0.203</td><td>0.220</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.466</td><td>p = 0.479</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MO</td><td>-0.325</td><td>0.145</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.194</td><td>p = 0.601</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_MT</td><td>0.051</td><td>0.328</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.851</td><td>p = 0.291</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NE</td><td>-0.204</td><td>0.255</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.456</td><td>p = 0.386</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NV</td><td>-0.640</td><td>0.185</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.017<sup>**</sup></td><td>p = 0.517</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NH</td><td>-0.544</td><td>-0.020</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.048<sup>**</sup></td><td>p = 0.947</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NJ</td><td>-0.107</td><td>0.337</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.680</td><td>p = 0.234</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NM</td><td>-0.472</td><td>0.291</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.088<sup>*</sup></td><td>p = 0.327</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NY</td><td>-0.181</td><td>0.384</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.478</td><td>p = 0.170</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_NC</td><td>-0.429</td><td>0.129</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.087<sup>*</sup></td><td>p = 0.641</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_ND</td><td>-0.181</td><td>0.037</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.592</td><td>p = 0.913</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OH</td><td>-0.419</td><td>0.038</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.095<sup>*</sup></td><td>p = 0.891</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OK</td><td>-0.599</td><td>0.095</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.028<sup>**</sup></td><td>p = 0.748</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_OR</td><td>-0.245</td><td>0.106</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.330</td><td>p = 0.705</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_PA</td><td>-0.238</td><td>0.206</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.339</td><td>p = 0.452</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_RI</td><td>0.024</td><td>0.173</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.935</td><td>p = 0.586</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SC</td><td>-0.314</td><td>0.512</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.221</td><td>p = 0.071<sup>*</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_SD</td><td>-0.181</td><td>0.200</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.550</td><td>p = 0.531</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TN</td><td>-0.251</td><td>-0.020</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.322</td><td>p = 0.943</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_TX</td><td>-0.704</td><td>0.225</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.005<sup>***</sup></td><td>p = 0.406</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_UT</td><td>-0.696</td><td>0.372</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.011<sup>**</sup></td><td>p = 0.208</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VT</td><td>-0.515</td><td>0.103</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.118</td><td>p = 0.765</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_VA</td><td>-0.474</td><td>0.138</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.057<sup>*</sup></td><td>p = 0.613</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WA</td><td>-0.312</td><td>0.236</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.215</td><td>p = 0.395</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WV</td><td>-0.309</td><td>0.228</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.245</td><td>p = 0.437</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WI</td><td>-0.445</td><td>0.140</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.076<sup>*</sup></td><td>p = 0.612</td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">.data_WY</td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td style="text-align:left">Constant</td><td>0.355</td><td>1.584</td></tr>
<tr><td style="text-align:left"></td><td>p = 0.465</td><td>p = 0.002<sup>***</sup></td></tr>
<tr><td style="text-align:left"></td><td></td><td></td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>31,374</td><td>38,926</td></tr>
<tr><td style="text-align:left">Log Likelihood</td><td>-11,652.300</td><td>-10,959.440</td></tr>
<tr><td style="text-align:left">Akaike Inf. Crit.</td><td>23,552.590</td><td>22,166.890</td></tr>
<tr><td colspan="3" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="2" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
</table>

```r
#stargazer(attitude,type='html',title='test')
```
