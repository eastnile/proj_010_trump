setproj(10)
---
  title: "Untitled"
author: "Zhaochen He"
date: "sysdate"
output: html_document
---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

```

## R Markdown


```{r results = 'asis'}
#stargazer(mod$ols$m,type='html',title='OLS with state FEs',report='vcp*')
#stargazer(mod$logit$m,type='html',title='OLS with state FEs',report='vcp*')
#stargazer(mod$probit$m,type='html',title='OLS with state FEs',report='vcp*')
#stargazer(attitude,type='html',title='test')

# stargazer(c(mod$probit$m,mod$probitfe$m),type='html',title='OLS with state FEs',report='vc*sp',covariate.labels=xlabels)



stargazer(c(mod$probitw$m, mod$probit$m), type = 'html', title = 'OLS with state FEs', report = 'vc*sp', covariate.labels = xlabels)

```
