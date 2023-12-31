TITLE NaP channel from RBD

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(S) = (siemens)
}

NEURON {
    THREADSAFE
    : note - every variable accessible in NEURON will be having the suffix _NaP

        SUFFIX NaP
        USEION na READ ena WRITE ina
        RANGE gmax,g
        GLOBAL tnmax,tlmax
}

PARAMETER {
: all values can be adjusted in hoc files
	gmax=0.001 (S/cm2)
	vhalfn=-45	(mV)
	vhalfl=-25	(mV)
	zn=8.2		(mV)
	zl=-6   	(mV)
	vn2=-45		(mV)
	vl2=-55		(mV)
	
	tlmax=10	(ms)
	tlmin=2.0	(ms)
	tls=6.5		(mV)
	tnmax=15	(ms)
	tnmin=5		(ms)
	tns=-8.5	(mV)
}

STATE {
        n
        l
}

ASSIGNED {
	v (mV)
    ena (mV)
	ina (mA/cm2)
	ninf3 (1)
	linf (1) 
	taul (ms)
	taun (ms)
	g (S/cm2)
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	g = gmax*n*l
	ina = g*(v-ena)
}

INITIAL {
	rates(v)
	n=ninf3
	l=linf
}


FUNCTION alpn(v(mV)) {
  alpn = exp((vhalfn-v)/zn)
}

FUNCTION betn(v(mV)) {
  betn = exp((vn2-v)/tns) 
}

FUNCTION alpl(v(mV)) {
  alpl = exp((vhalfl-v)/zl)
}

DERIVATIVE states {  
	rates(v)
	n' = (ninf3 - n)/taun
	l' = (linf - l)/taul
}

PROCEDURE rates(v (mV)) { :callable from hoc
	LOCAL a, ninf
	TABLE ninf3, taun, linf, taul DEPEND tlmax, tnmax, vhalfn, vhalfl, tlmin, tnmin
		FROM -100 TO 50 WITH 1500

	a = alpn(v)
	ninf = 1/(1 + a)
	ninf3=ninf^3
	taun = 4*tnmax/(1+betn(v))*ninf+tnmin
	a = alpl(v)
	linf = (1/(1+ a))
	taul = 2*tlmax/(1+exp((vl2-v)/tls))*linf + tlmin
}

