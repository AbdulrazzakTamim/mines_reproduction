*----------------------------------------------------------------------------------------------------------------------------------------------------*
* This program performs the estimations of Tables 4, A.29, A.30, A.31 (online appendix) of "This mine is mine: how minerals fuel conflicts in Africa"
* This version: October 2016
*----------------------------------------------------------------------------------------------------------------------------------------------------*


* ------------------------------------------------------------------------------------ *
					*  Table 4 - Mines in ethnic homelands *
* ------------------------------------------------------------------------------------ *

cap log close
log using "$Results/Table_4.log", replace

use "$Output_data/BCRT_actor_ethnic", clear

egen actor_country 	= group(actor iso_1)
egen it 			= group(iso_1 year)
egen actor_group 	= group(actor)

gen acled_exclu_ethnic = nb_acled_exclu_ethnic>0

g interact_t0 		= price_ethnic*mines_t0 
g interact_t0_ni 	= price_ethnic_ni*mines_t0_ni 
g interact_t0_nh 	= price_ethnic_nh*mines_t0_nh

label var price_ethnic 		"ln price main mineral (homeland in country)"
label var interact_t0  		"ln price main mineral (homeland in country) $\times$ \# mines"
label var price_ethnic_ni 	"ln price main mineral (entire homeland)"
label var interact_t0_ni 	"ln price main mineral (entire  homeland) $\times$ \# mines"
label var price_ethnic_nh 	"ln price main mineral (in country outside homeland)"
label var interact_t0_nh 	"ln price main mineral (in country outside homeland) $\times$ \# mines"

* Baseline
eststo: reghdfe acled   			 price_ethnic mines_t0 interact_t0 if sd_mine_ethnic==0, absorb(actor_country year) vce(cluster actor_group)   
eststo: reghdfe acled   			 price_ethnic mines_t0 interact_t0 if sd_mine_ethnic==0, absorb(actor_country it) vce(cluster actor_group)   
* Excluding homeland
eststo: reghdfe acled_exclu_ethnic   price_ethnic mines_t0 interact_t0 if sd_mine_ethnic==0, absorb(actor_country year) vce(cluster actor_group)   
eststo: reghdfe acled_exclu_ethnic   price_ethnic mines_t0 interact_t0 if sd_mine_ethnic==0, absorb(actor_country it) vce(cluster actor_group)   
* Splitting the effect
eststo: reghdfe acled  				 price_ethnic mines_t0 interact_t0 price_ethnic_ni mines_t0_ni interact_t0_ni price_ethnic_nh mines_t0_nh interact_t0_nh if sd_mine_ethnic==0, absorb(actor_country year) vce(cluster actor_group)   
eststo: reghdfe acled_exclu_ethnic   price_ethnic mines_t0 interact_t0 price_ethnic_ni mines_t0_ni interact_t0_ni price_ethnic_nh mines_t0_nh interact_t0_nh if sd_mine_ethnic==0, absorb(actor_country year) vce(cluster actor_group)   

set linesize 250
esttab, mtitles drop(mines*) b(%5.3f) se(%5.3f) compress r2 starlevels(c 0.1 b 0.05 a 0.01)  se 
esttab, mtitles drop(mines*) b(%5.3f) se(%5.3f) r2  starlevels({$^c$} 0.1 {$^b$} 0.05 {$^a$} 0.01) se tex label  title(Table 4) 
eststo clear

log close



/////////ROBUSTNESS #1
g mines2_t0 = mines_t0>0 if !mi(mines_t0)
g interact2_t0 = price_ethnic*mines2_t0 

* Baseline
eststo: reghdfe acled price_ethnic mines_t0 interact_t0 if sd_mine_ethnic==0, absorb(actor_country year) vce(cluster actor_group)   
eststo: reghdfe acled price_ethnic mines2_t0 interact2_t0 if sd_mine_ethnic==0, absorb(actor_country year) vce(cluster actor_group)   

eststo: reghdfe acled price_ethnic mines_t0 interact_t0 if sd_mine_ethnic==0, absorb(actor_country it) vce(cluster actor_group)   
eststo: reghdfe acled price_ethnic mines2_t0 interact2_t0 if sd_mine_ethnic==0, absorb(actor_country it) vce(cluster actor_group)   
