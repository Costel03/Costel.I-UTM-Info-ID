EXERCITII PENTRU CAIET - CALCUL DIFERENTIAL SI INTEGRAL
Universitatea Titu Maiorescu - Informatica Anul I ID


===============================================
CAPITOL 1: SIRURI DE NUMERE REALE
===============================================

Exercitiul 1.1 - Puncte limita ale unui sir

Cerinta: Sa se determine punctele limita pentru sirul:
u_n = (-1)^(n-1) + 1

Rezolvare:
Pentru n impar: u_n = -1 + 1 = 0
Pentru n par: u_n = 1 + 1 = 2

Concluzie: Punctele limita sunt 0 si 2.


Exercitiul 1.2 - Limita superioara si inferioara

Cerinta: Sa se determine limsup u_n si liminf u_n pentru:
u_n = 1/2 + (-1)^n * n/(2n+1)

Rezolvare:
Pentru n par:
u_2k = 1/2 + 2k/(4k+1) → 1/2 + 1/2 = 3/2

Pentru n impar:
u_2k+1 = 1/2 - (2k+1)/(4k+3) → 1/2 - 1/2 = 1/2

Deci limsup u_n = 3/2 si liminf u_n = 1/2.


Exercitiul 1.3 - Convergenta sirurilor (Teorema Weierstrass)

Cerinta: Sa se studieze convergenta sirului definit prin recurenta:
a_(n+1) = √(a + a_n),  a > 0,  a_0 = 0

Rezolvare:
Pasul 1: Demonstram prin inductie ca sirul este crescator.
Pentru n=0: a_1 = √a > 0 = a_0 ✓
Presupunem a_n > a_(n-1). Atunci:
a_(n+1) = √(a + a_n) > √(a + a_(n-1)) = a_n ✓

Pasul 2: Demonstram ca sirul este marginit superior.
Presupunem ca exista limita ℓ = lim a_n.
Trecand la limita in relatia de recurenta:
ℓ = √(a + ℓ)

Ridicam la patrat:
ℓ² = a + ℓ
ℓ² - ℓ - a = 0

Rezolvam ecuatia:
ℓ = (1 ± √(1+4a))/2

Cum ℓ > 0, rezulta:
ℓ = (1 + √(1+4a))/2


Exercitiul 1.4 - Teorema Cesaro-Stolz

Cerinta: Sa se calculeze:
lim (1^p + 2^p + ... + n^p)/n^(p+1),  p ≥ 1
n→∞

Rezolvare:
Notam a_n = 1^p + 2^p + ... + n^p si b_n = n^(p+1).

Aplicam Teorema Cesaro-Stolz:
lim a_n/b_n = lim (a_(n+1) - a_n)/(b_(n+1) - b_n)
n→∞         n→∞

Calculam:
a_(n+1) - a_n = (n+1)^p
b_(n+1) - b_n = (n+1)^(p+1) - n^(p+1) ≈ (p+1)n^p pentru n mare

Deci:
lim (n+1)^p/((p+1)n^p) = 1/(p+1)
n→∞

Raspuns: 1/(p+1)


Exercitiul 1.5 - Criteriul radicalului

Cerinta: Sa se calculeze lim ⁿ√(n!)
                      n→∞

Rezolvare:
Aplicam criteriul raportului:
lim a_(n+1)/a_n = lim (n+1)!/n! = lim (n+1) = ∞
n→∞               n→∞              n→∞

Deci lim ⁿ√(n!) = ∞
    n→∞


Exercitiul 1.6 - Criteriul lui Cauchy

Cerinta: Sa se arate ca sirul:
u_n = sin(a_1)/2 + sin(a_2)/2² + ... + sin(a_n)/2^n
este convergent.

Rezolvare:
Fie ε > 0. Trebuie sa aratam ca există n₀ astfel incat pentru orice n, m ≥ n₀:
|u_n - u_m| < ε

Presupunem n > m. Atunci:
|u_n - u_m| = |sin(a_(m+1))/2^(m+1) + ... + sin(a_n)/2^n|

Cum |sin x| ≤ 1:
|u_n - u_m| ≤ 1/2^(m+1) + ... + 1/2^n = 1/2^(m+1) · (1 - 1/2^(n-m))/(1 - 1/2)

|u_n - u_m| ≤ 1/2^m

Pentru ε dat, alegem n₀ astfel incat 1/2^n₀ < ε.
Deci sirul este convergent (Cauchy).


===============================================
CAPITOL 2: SERII DE NUMERE REALE
===============================================

Exercitiul 2.1 - Suma unei serii geometrice

Cerinta: Sa se arate ca seria este convergenta si sa se determine suma:
1/3 - 1/9 + 1/27 - ... + (-1)^(n+1) · 1/3^n + ...

Rezolvare:
Este o serie geometrica cu:
a₁ = 1/3
q = -1/3

Verificam |q| = 1/3 < 1, deci seria este convergenta.

Suma:
S = a₁/(1-q) = (1/3)/(1-(-1/3)) = (1/3)/(4/3) = 1/4

Raspuns: S = 1/4


Exercitiul 2.2 - Criteriul raportului (d'Alembert)

Cerinta: Sa se studieze natura seriei:
Σ n!/n^n
n=1

Rezolvare:
Calculam:
a_(n+1)/a_n = [(n+1)!/(n+1)^(n+1)] · [n^n/n!]

= (n+1)! · n^n/(n! · (n+1)^(n+1))

= (n+1) · n^n/(n+1)^(n+1)

= n^n/(n+1)^n

= (n/(n+1))^n

= (1/(1+1/n))^n

Calculam limita:
lim (n/(n+1))^n = lim 1/(1+1/n)^n = 1/e < 1
n→∞              n→∞

Concluzie: Seria este convergenta (criteriul raportului).


Exercitiul 2.3 - Criteriul Leibniz (serii alternate)

Cerinta: Sa se demonstreze convergenta seriei:
Σ (-1)^(n+1) · 1/n = 1 - 1/2 + 1/3 - 1/4 + ...
n=1

Rezolvare:
Verificam conditiile lui Leibniz:

1) u_n = 1/n > 0 ✓

2) Sirul (u_n) este monoton descrescator:
   1/n > 1/(n+1) pentru orice n ∈ ℕ* ✓

3) lim u_n = lim 1/n = 0 ✓
   n→∞      n→∞

Toate conditiile sunt indeplinite.

Concluzie: Seria este convergenta (seria armonica alternata).


Exercitiul 2.4 - Criteriul comparatiei I

Cerinta: Sa se studieze natura seriei:
Σ 1/(n² + 1)
n=1

Rezolvare:
Comparam cu seria:
Σ 1/n²  (care este convergenta, deoarece α = 2 > 1)
n=1

Pentru orice n ≥ 1:
0 < 1/(n² + 1) < 1/n²

Aplicam criteriul comparatiei I:
Daca Σ 1/n² este convergenta si 1/(n²+1) < 1/n²,
atunci Σ 1/(n²+1) este convergenta.

Concluzie: Seria este convergenta.


Exercitiul 2.5 - Criteriul comparatiei la limita

Cerinta: Sa se studieze natura seriei:
Σ (2n+1)/(n³+n+1)
n=1

Rezolvare:
Pentru n mare, termenul general se comporta ca:
a_n ≈ 2n/n³ = 2/n²

Comparam cu seria Σ 1/n² (convergenta).

Calculam:
lim a_n/(1/n²) = lim [(2n+1)/(n³+n+1)] · n²
n→∞             n→∞

= lim (2n³ + n²)/(n³ + n + 1)
  n→∞

= lim (2 + 1/n)/(1 + 1/n² + 1/n³)
  n→∞

= 2

Cum 0 < 2 < ∞, cele doua serii au aceeasi natura.

Concluzie: Seria este convergenta.


Exercitiul 2.6 - Criteriul radacinii (Cauchy)

Cerinta: Sa se studieze natura seriei:
Σ (n/(2n+1))^n
n=1

Rezolvare:
Aplicam criteriul radacinii:
ℓ = lim ⁿ√a_n = lim ⁿ√[(n/(2n+1))^n]
    n→∞         n→∞

= lim n/(2n+1)
  n→∞

= lim 1/(2 + 1/n)
  n→∞

= 1/2 < 1

Concluzie: Seria este convergenta (criteriul radacinii).


Exercitiul 2.7 - Serie semiconvergenta

Cerinta: Sa se arate ca seria Σ (-1)^(n+1)/n este semiconvergenta.
                           n=1

Rezolvare:
Pasul 1: Studiem convergenta seriei.
Din Exercitiul 2.3, stim ca seria este convergenta (Leibniz).

Pasul 2: Studiem convergenta absoluta.
Seria modulelor este:
Σ |(-1)^(n+1)/n| = Σ 1/n (seria armonica)
n=1                n=1

Seria armonica este divergenta (α = 1).

Concluzie: Seria este convergenta dar nu absolut convergenta,
deci este semiconvergenta.


===============================================
CAPITOL 3: SERII DE PUTERI
===============================================

Exercitiul 3.1 - Raza de convergenta (formula d'Alembert)

Cerinta: Sa se determine raza si intervalul de convergenta pentru seria:
Σ x^n/(n·2^n)
n=1

Rezolvare:
Notam a_n = 1/(n·2^n)

Calculam:
ρ = lim |a_n/a_(n+1)| = lim |[1/(n·2^n)]/[1/((n+1)·2^(n+1))]|
    n→∞                 n→∞

= lim (n+1)·2^(n+1)/(n·2^n)
  n→∞

= lim 2(n+1)/n
  n→∞

= lim 2(1 + 1/n)
  n→∞

= 2

Raza de convergenta: ρ = 2
Intervalul de convergenta: (-2, 2)

Studiem capetele intervalului:

Pentru x = 2:
Σ 2^n/(n·2^n) = Σ 1/n (divergenta - seria armonica)
n=1             n=1

Pentru x = -2:
Σ (-2)^n/(n·2^n) = Σ (-1)^n/n (convergenta - Leibniz)
n=1                n=1

Multimea de convergenta: [-2, 2)


Exercitiul 3.2 - Raza de convergenta (formula Cauchy-Hadamard)

Cerinta: Sa se determine raza de convergenta pentru seria:
Σ n^n·x^n
n=1

Rezolvare:
Aplicam formula Cauchy-Hadamard:
ρ = 1/limsup ⁿ√|a_n|
      n→∞

Calculam:
ⁿ√|a_n| = ⁿ√|n^n| = n

Deci:
limsup n = ∞
n→∞

Rezulta:
ρ = 1/∞ = 0

Concluzie: Raza de convergenta este 0.
Seria converge doar pentru x = 0.


Exercitiul 3.3 - Dezvoltare in serie Mac-Laurin (e^x)

Cerinta: Sa se dezvolte in serie de puteri functia f(x) = e^x

Rezolvare:
Calculam derivatele succesive:
f(x) = e^x
f'(x) = e^x
f''(x) = e^x
...
f^(n)(x) = e^x

In punctul x = 0:
f(0) = 1
f'(0) = 1
f''(0) = 1
...
f^(n)(0) = 1

Formula Mac-Laurin:
f(x) = Σ f^(n)(0)·x^n/n!
       n=0

Deci:
e^x = Σ x^n/n! = 1 + x + x²/2! + x³/3! + ...
      n=0

Seria este convergenta pentru orice x ∈ ℝ.


Exercitiul 3.4 - Dezvoltare in serie Mac-Laurin (sin x)

Cerinta: Sa se dezvolte in serie de puteri functia f(x) = sin x

Rezolvare:
Calculam derivatele:
f(x) = sin x       → f(0) = 0
f'(x) = cos x      → f'(0) = 1
f''(x) = -sin x    → f''(0) = 0
f'''(x) = -cos x   → f'''(0) = -1
f^(4)(x) = sin x   → f^(4)(0) = 0
...

Observam ca:
- Derivatele de ordin par in x=0 sunt 0
- Derivatele de ordin impar alterneaza intre 1 si -1

Formula Mac-Laurin:
sin x = x - x³/3! + x⁵/5! - x⁷/7! + ...

= Σ (-1)^n · x^(2n+1)/(2n+1)!
  n=0

Seria este convergenta pentru orice x ∈ ℝ.


Exercitiul 3.5 - Dezvoltare in serie Mac-Laurin (cos x)

Cerinta: Sa se dezvolte in serie de puteri functia f(x) = cos x

Rezolvare:
Similar cu sin x, calculam derivatele:
f(x) = cos x       → f(0) = 1
f'(x) = -sin x     → f'(0) = 0
f''(x) = -cos x    → f''(0) = -1
f'''(x) = sin x    → f'''(0) = 0
f^(4)(x) = cos x   → f^(4)(0) = 1
...

Formula Mac-Laurin:
cos x = 1 - x²/2! + x⁴/4! - x⁶/6! + ...

= Σ (-1)^n · x^(2n)/(2n)!
  n=0

Seria este convergenta pentru orice x ∈ ℝ.


Exercitiul 3.6 - Suma unei serii de puteri

Cerinta: Sa se calculeze suma seriei:
Σ x^(2n)/(2n+1)
n=0

Rezolvare:
Derivam termen cu termen:
d/dx[Σ x^(2n)/(2n+1)] = Σ x^(2n-1)·2n/(2n+1)
      n=0               n=0

= Σ 2x^(2n-1)·n/(2n+1)
  n=0

Aceasta derivare nu simplifica problema.

Incercam alta abordare. Notam S(x) = Σ x^(2n)/(2n+1)
                                      n=0

Observam ca pentru x ∈ (-1,1):
S(x) = 1/x · Σ x^(2n+1)/(2n+1)
             n=0

Recunoastem dezvoltarea:
arctg(x) = Σ (-1)^n · x^(2n+1)/(2n+1)
           n=0

Deci pentru x²:
arctg(x²) = Σ (-1)^n · x^(4n+2)/(2n+1)
            n=0

Nu se potriveste exact. Seria noastra este:
S(x) = (1/x)·arctg(x) pentru |x| < 1


Exercitiul 3.7 - Ecuatie diferentiala cu serii de puteri

Cerinta: Sa se gaseasca o serie de puteri Σ a_n·x^n care verifica:
                                          n=0
f'(x) - xf(x) = 0,  f(0) = 1

Rezolvare:
Presupunem f(x) = Σ a_n·x^n
                  n=0

Atunci:
f'(x) = Σ n·a_n·x^(n-1)
        n=1

xf(x) = Σ a_n·x^(n+1)
        n=0

Egalitatea f'(x) = xf(x) devine:
Σ n·a_n·x^(n-1) = Σ a_n·x^(n+1)
n=1               n=0

Schimbam indicii:
Σ (n+1)·a_(n+1)·x^n = Σ a_(n-1)·x^n
n=0                    n=1

Egaland coeficientii:
Pentru n=0: a₁ = 0
Pentru n≥1: (n+1)·a_(n+1) = a_(n-1)

Din a₁ = 0 rezulta ca toti coeficientii de rang impar sunt 0.

Pentru n par, n=2k:
(2k+1)·a_(2k+1) = a_(2k-1) = 0

Pentru coeficientii pari, avem:
a₂ = a₀/(1·2)
a₄ = a₂/(3·4) = a₀/(1·2·3·4)
a₆ = a₀/(1·2·3·4·5·6)

In general: a_(2k) = a₀/(2k)!

Cu conditia f(0) = a₀ = 1:
f(x) = Σ x^(2k)/(2k)! = cosh(x)
       k=0


===============================================
CAPITOL 4: DERIVATE PARTIALE
===============================================

Exercitiul 4.1 - Derivate partiale de ordinul I

Cerinta: Sa se calculeze derivatele partiale pentru:
f(x,y) = x² + y² + xy

Rezolvare:
Derivata partiala in raport cu x (consideram y constant):
∂f/∂x = 2x + y

Derivata partiala in raport cu y (consideram x constant):
∂f/∂y = 2y + x


Exercitiul 4.2 - Derivate partiale de ordinul II

Cerinta: Sa se calculeze derivatele partiale de ordin II pentru:
f(x,y) = ln(1 + x² + y²)

Rezolvare:
Pasul 1: Derivatele de ordinul I
∂f/∂x = 2x/(1 + x² + y²)

∂f/∂y = 2y/(1 + x² + y²)

Pasul 2: Derivatele de ordinul II
∂²f/∂x² = [2(1+x²+y²) - 2x·2x]/(1+x²+y²)²
        = [2 - 2x² + 2y²]/(1+x²+y²)²
        = (2 - 2x² + 2y²)/(1+x²+y²)²

∂²f/∂y² = [2(1+x²+y²) - 2y·2y]/(1+x²+y²)²
        = (2 + 2x² - 2y²)/(1+x²+y²)²

∂²f/∂x∂y = [-2x·2y]/(1+x²+y²)²
         = -4xy/(1+x²+y²)²

∂²f/∂y∂x = -4xy/(1+x²+y²)²

Verificam criteriul Schwarz:
∂²f/∂x∂y = ∂²f/∂y∂x ✓


Exercitiul 4.3 - Diferentiala totala

Cerinta: Sa se calculeze diferentiala totala pentru:
f(x,y,z) = x² + y² + z²

Rezolvare:
Calculam derivatele partiale:
∂f/∂x = 2x
∂f/∂y = 2y
∂f/∂z = 2z

Diferentiala totala:
df = (∂f/∂x)dx + (∂f/∂y)dy + (∂f/∂z)dz

df = 2x·dx + 2y·dy + 2z·dz


Exercitiul 4.4 - Derivata functiei compuse

Cerinta: Sa se calculeze ∂F/∂x si ∂F/∂y pentru:
F(x,y) = f(x²+y², xy)
unde f este o functie diferentiabila.

Rezolvare:
Notam u = x² + y² si v = xy.

Aplicam regula lantului:
∂F/∂x = (∂f/∂u)·(∂u/∂x) + (∂f/∂v)·(∂v/∂x)

Calculam:
∂u/∂x = 2x
∂v/∂x = y

Deci:
∂F/∂x = (∂f/∂u)·2x + (∂f/∂v)·y

Similar:
∂F/∂y = (∂f/∂u)·2y + (∂f/∂v)·x


Exercitiul 4.5 - Verificare daca o expresie este diferentiala exacta

Cerinta: Sa se verifice daca expresia:
(2x + y)dx + (x + 2y)dy
este diferentiala exacta.

Rezolvare:
Pentru P(x,y)dx + Q(x,y)dy sa fie diferentiala exacta,
trebuie ca ∂P/∂y = ∂Q/∂x.

Avem:
P(x,y) = 2x + y  → ∂P/∂y = 1
Q(x,y) = x + 2y  → ∂Q/∂x = 1

Cum ∂P/∂y = ∂Q/∂x = 1, expresia este diferentiala exacta.

Gasim functia f astfel incat df = (2x+y)dx + (x+2y)dy:

∂f/∂x = 2x + y  → f = x² + xy + g(y)

∂f/∂y = x + g'(y) = x + 2y  → g'(y) = 2y  → g(y) = y²

Deci: f(x,y) = x² + xy + y² + C


===============================================
CAPITOL 5: EXTREME LIBERE SI CONDITIONATE
===============================================

Exercitiul 5.1 - Extreme libere (functii de 2 variabile)

Cerinta: Sa se determine extremele functiei:
f(x,y) = x² + xy + y² - 3x - 6y

Rezolvare:
Pasul 1: Gasim punctele critice.
Rezolvam sistemul:
∂f/∂x = 2x + y - 3 = 0
∂f/∂y = x + 2y - 6 = 0

Din prima ecuatie: y = 3 - 2x
Inlocuim in a doua: x + 2(3-2x) - 6 = 0
                    x + 6 - 4x - 6 = 0
                    -3x = 0
                    x = 0

Rezulta y = 3.
Punct critic: (0, 3)

Pasul 2: Studiem natura punctului critic.
Calculam derivatele de ordinul II:
∂²f/∂x² = 2
∂²f/∂y² = 2
∂²f/∂x∂y = 1

Matricea Hessiana:
H = |2  1|
    |1  2|

det(H) = 2·2 - 1·1 = 3 > 0
∂²f/∂x²(0,3) = 2 > 0

Concluzie: (0,3) este punct de minim local.

Valoarea minimului:
f(0,3) = 0 + 0 + 9 - 0 - 18 = -9


Exercitiul 5.2 - Identificare tip punct critic

Cerinta: Sa se determine natura punctului critic (0,0) pentru:
f(x,y) = x² - y²

Rezolvare:
Verificam ca (0,0) este punct critic:
∂f/∂x = 2x  → ∂f/∂x(0,0) = 0 ✓
∂f/∂y = -2y → ∂f/∂y(0,0) = 0 ✓

Calculam derivatele de ordinul II:
∂²f/∂x² = 2
∂²f/∂y² = -2
∂²f/∂x∂y = 0

Matricea Hessiana:
H = |2   0|
    |0  -2|

det(H) = 2·(-2) - 0 = -4 < 0

Concluzie: (0,0) este punct de sa (punct de inflexiune).
Functia nu are nici minim, nici maxim in acest punct.


Exercitiul 5.3 - Extreme conditionate (metoda multiplicatorilor Lagrange)

Cerinta: Sa se determine extremele functiei:
f(x,y) = x + y
cu conditia: x² + y² = 1

Rezolvare:
Pasul 1: Formam functia Lagrange.
L(x,y,λ) = f(x,y) - λ·g(x,y)
unde g(x,y) = x² + y² - 1 = 0

L(x,y,λ) = x + y - λ(x² + y² - 1)

Pasul 2: Rezolvam sistemul:
∂L/∂x = 1 - 2λx = 0  →  x = 1/(2λ)
∂L/∂y = 1 - 2λy = 0  →  y = 1/(2λ)
∂L/∂λ = -(x² + y² - 1) = 0  →  x² + y² = 1

Din primele doua ecuatii: x = y = 1/(2λ)

Inlocuim in a treia:
2·[1/(2λ)]² = 1
1/(2λ²) = 1
λ² = 1/2
λ = ±1/√2

Pentru λ = 1/√2:
x = y = 1/(2·1/√2) = √2/2

Pentru λ = -1/√2:
x = y = 1/(2·(-1/√2)) = -√2/2

Pasul 3: Calculam valorile functiei.
f(√2/2, √2/2) = √2/2 + √2/2 = √2  (maxim)
f(-√2/2, -√2/2) = -√2/2 - √2/2 = -√2  (minim)

Puncte de extrem:
Maxim: (√2/2, √2/2) cu f = √2
Minim: (-√2/2, -√2/2) cu f = -√2


Exercitiul 5.4 - Extreme conditionate (exemplu practic)

Cerinta: Sa se gaseasca dimensiunile unei cutii dreptunghiulare cu volum maxim,
avand suprafata totala egala cu 6.

Rezolvare:
Notam cu x, y, z dimensiunile cutiei.

Functia de maximizat:
V(x,y,z) = xyz

Conditia (suprafata totala):
2(xy + xz + yz) = 6  sau  xy + xz + yz = 3

Formam functia Lagrange:
L = xyz - λ(xy + xz + yz - 3)

Sistem:
∂L/∂x = yz - λ(y + z) = 0  →  yz = λ(y+z)
∂L/∂y = xz - λ(x + z) = 0  →  xz = λ(x+z)
∂L/∂z = xy - λ(x + y) = 0  →  xy = λ(x+y)
∂L/∂λ = -(xy + xz + yz - 3) = 0

Din primele trei ecuatii, daca presupunem x = y = z:
x² = λ·2x  →  λ = x/2

Din conditie:
3x² = 3  →  x² = 1  →  x = 1 (pozitiv)

Deci x = y = z = 1.

Verificare: 2(1·1 + 1·1 + 1·1) = 6 ✓

Volumul maxim: V = 1·1·1 = 1

Raspuns: Cutia este cub cu latura 1.


===============================================
CAPITOL 6: INTEGRALE IMPROPRII
===============================================

Exercitiul 6.1 - Integrala improprie convergenta (speța I)

Cerinta: Sa se calculeze:
∫₀^∞ e^(-αx) dx,  α > 0

Rezolvare:
Calculam:
I = lim[u→∞] ∫₀^u e^(-αx) dx

= lim[u→∞] [-1/α · e^(-αx)]₀^u

= lim[u→∞] [-1/α · e^(-αu) + 1/α · e^0]

= lim[u→∞] [1/α - 1/α · e^(-αu)]

= 1/α - 0

= 1/α

Raspuns: 1/α


Exercitiul 6.2 - Convergenta integralei (criteriul comparatiei)

Cerinta: Sa se studieze convergenta integralei:
∫₁^∞ dx/x^α

Rezolvare:
Cazul 1: α ≠ 1
∫₁^u dx/x^α = [x^(1-α)/(1-α)]₁^u = [u^(1-α) - 1]/(1-α)

Pentru α > 1: 1-α < 0, deci u^(1-α) → 0 cand u → ∞
Limita = -1/(1-α) = 1/(α-1)  CONVERGENTA

Pentru α < 1: 1-α > 0, deci u^(1-α) → ∞ cand u → ∞
DIVERGENTA

Cazul 2: α = 1
∫₁^u dx/x = ln(u) → ∞ cand u → ∞
DIVERGENTA

Concluzie:
∫₁^∞ dx/x^α este convergenta ⟺ α > 1


Exercitiul 6.3 - Integrala improprie (speța II)

Cerinta: Sa se calculeze:
∫₀^1 dx/√x

Rezolvare:
Functia are singularitate in x = 0.

I = lim[ε→0⁺] ∫ₑ^1 x^(-1/2) dx

= lim[ε→0⁺] [2√x]ₑ^1

= lim[ε→0⁺] (2√1 - 2√ε)

= 2 - 0

= 2

Raspuns: 2 (integrala este convergenta)


Exercitiul 6.4 - Criteriul comparatiei (practică)

Cerinta: Sa se studieze convergenta:
∫₁^∞ ln(x)/(x³) dx

Rezolvare:
Pentru x > e², avem ln(x) < x, deci:
ln(x)/x³ < x/x³ = 1/x²

Cum ∫₁^∞ dx/x² este convergenta (α = 2 > 1),
si ln(x)/x³ < 1/x² pentru x suficient de mare,

rezulta ca ∫₁^∞ ln(x)/x³ dx este convergenta (criteriul comparatiei).


Exercitiul 6.5 - Integrala cu parametru

Cerinta: Sa se calculeze:
I(a) = ∫₀^∞ e^(-ax) sin(x) dx,  a > 0

Rezolvare:
Integram prin parti de doua ori.

Prima integrare prin parti:
u = sin(x)     dv = e^(-ax)dx
du = cos(x)dx  v = -1/a · e^(-ax)

∫ e^(-ax)sin(x)dx = -1/a · e^(-ax)sin(x) + 1/a ∫ e^(-ax)cos(x)dx

A doua integrare prin parti:
u = cos(x)     dv = e^(-ax)dx
du = -sin(x)dx v = -1/a · e^(-ax)

∫ e^(-ax)cos(x)dx = -1/a · e^(-ax)cos(x) - 1/a ∫ e^(-ax)sin(x)dx

Combinand:
I = -1/a · e^(-ax)sin(x) + 1/a[-1/a · e^(-ax)cos(x) - 1/a · I]

I = -1/a · e^(-ax)sin(x) - 1/a² · e^(-ax)cos(x) - 1/a² · I

I(1 + 1/a²) = -e^(-ax)/a[sin(x) + 1/a · cos(x)]

I = -a/(a²+1) · e^(-ax)[sin(x) + 1/a · cos(x)]|₀^∞

= 0 - (-a/(a²+1) · 1/a)

= 1/(a²+1)

Raspuns: I(a) = 1/(1+a²)


===============================================
CAPITOL 7: INTEGRALA DUBLA
===============================================

Exercitiul 7.1 - Calcul integrala dubla pe dreptunghi

Cerinta: Sa se calculeze:
∬_D (x + y) dxdy
unde D = {(x,y) : 0 ≤ x ≤ 1, 0 ≤ y ≤ 1}

Rezolvare:
I = ∫₀^1 (∫₀^1 (x+y) dy) dx

Calculam integrala interioara:
∫₀^1 (x+y) dy = [xy + y²/2]₀^1 = x + 1/2

Calculam integrala exterioara:
∫₀^1 (x + 1/2) dx = [x²/2 + x/2]₀^1 = 1/2 + 1/2 = 1

Raspuns: 1


Exercitiul 7.2 - Integrala dubla pe domeniu triangular

Cerinta: Sa se calculeze:
∬_D xy dxdy
unde D = {(x,y) : 0 ≤ x ≤ 1, 0 ≤ y ≤ x}

Rezolvare:
I = ∫₀^1 (∫₀^x xy dy) dx

Integrala interioara (x este constant):
∫₀^x xy dy = x[y²/2]₀^x = x · x²/2 = x³/2

Integrala exterioara:
∫₀^1 x³/2 dx = 1/2 · [x⁴/4]₀^1 = 1/2 · 1/4 = 1/8

Raspuns: 1/8


Exercitiul 7.3 - Schimbare in coordonate polare

Cerinta: Sa se calculeze:
∬_D (x² + y²) dxdy
unde D: x² + y² ≤ R²

Rezolvare:
Trecem in coordonate polare:
x = r·cos(θ)
y = r·sin(θ)
dxdy = r dr dθ

Domeniul devine:
0 ≤ r ≤ R
0 ≤ θ ≤ 2π

Expresia devine:
x² + y² = r²

I = ∫₀^(2π) (∫₀^R r² · r dr) dθ

= ∫₀^(2π) dθ · ∫₀^R r³ dr

= 2π · [r⁴/4]₀^R

= 2π · R⁴/4

= πR⁴/2

Raspuns: πR⁴/2


Exercitiul 7.4 - Aria unui domeniu

Cerinta: Sa se calculeze aria domeniului:
D = {(x,y) : x² + y² ≤ 4, x ≥ 0, y ≥ 0}

Rezolvare:
Este primul cadran al discului de raza 2.

In coordonate polare:
0 ≤ r ≤ 2
0 ≤ θ ≤ π/2

Aria = ∬_D dxdy = ∫₀^(π/2) (∫₀^2 r dr) dθ

= ∫₀^(π/2) [r²/2]₀^2 dθ

= ∫₀^(π/2) 2 dθ

= 2[θ]₀^(π/2)

= 2 · π/2

= π

Raspuns: π (un sfert din aria cercului de raza 2)


Exercitiul 7.5 - Integrala dubla cu schimbare de ordine

Cerinta: Sa se calculeze:
I = ∫₀^1 (∫ᵧ^1 e^(x²) dx) dy

Rezolvare:
Domeniul initial:
0 ≤ y ≤ 1
y ≤ x ≤ 1

Schimbam ordinea de integrare:
0 ≤ x ≤ 1
0 ≤ y ≤ x

I = ∫₀^1 (∫₀^x e^(x²) dy) dx

= ∫₀^1 e^(x²) · [y]₀^x dx

= ∫₀^1 x · e^(x²) dx

Substituim u = x², du = 2x dx:

= 1/2 ∫₀^1 e^u du

= 1/2 [e^u]₀^1

= 1/2 (e - 1)

Raspuns: (e - 1)/2


===============================================
CAPELA 8: INTEGRALA TRIPLA
===============================================

Exercitiul 8.1 - Integrala tripla pe paralelipiped

Cerinta: Sa se calculeze:
∭_V xyz dxdydz
unde V = {(x,y,z) : 0 ≤ x ≤ 1, 0 ≤ y ≤ 1, 0 ≤ z ≤ 1}

Rezolvare:
I = ∫₀^1 (∫₀^1 (∫₀^1 xyz dz) dy) dx

Integrala dupa z:
∫₀^1 xyz dz = xy[z²/2]₀^1 = xy/2

Integrala dupa y:
∫₀^1 xy/2 dy = x/2 · [y²/2]₀^1 = x/4

Integrala dupa x:
∫₀^1 x/4 dx = 1/4 · [x²/2]₀^1 = 1/8

Raspuns: 1/8


Exercitiul 8.2 - Volumul unei sfere

Cerinta: Sa se calculeze volumul sferei x² + y² + z² ≤ R³

Rezolvare:
Trecem in coordonate sferice:
x = r·sin(φ)·cos(θ)
y = r·sin(φ)·sin(θ)
z = r·cos(φ)
dxdydz = r²·sin(φ) dr dφ dθ

Domeniul:
0 ≤ r ≤ R
0 ≤ φ ≤ π
0 ≤ θ ≤ 2π

V = ∫₀^(2π) (∫₀^π (∫₀^R r²·sin(φ) dr) dφ) dθ

= ∫₀^(2π) dθ · ∫₀^π sin(φ) dφ · ∫₀^R r² dr

= 2π · [-cos(φ)]₀^π · [r³/3]₀^R

= 2π · 2 · R³/3

= 4πR³/3

Raspuns: 4πR³/3


===============================================
CAPITOL 9: INTEGRALA CURBILINIE
===============================================

Exercitiul 9.1 - Lungimea unei curbe (tipul I)

Cerinta: Sa se calculeze lungimea cicloidei:
x = t - sin(t)
y = 1 - cos(t)
t ∈ [0, 2π]

Rezolvare:
Formula pentru lungime:
L = ∫₀^(2π) √[(x'(t))² + (y'(t))²] dt

Calculam derivatele:
x'(t) = 1 - cos(t)
y'(t) = sin(t)

(x')² + (y')² = (1-cos(t))² + sin²(t)
             = 1 - 2cos(t) + cos²(t) + sin²(t)
             = 1 - 2cos(t) + 1
             = 2 - 2cos(t)
             = 2(1 - cos(t))

√[(x')² + (y')²] = √[2(1-cos(t))]

Folosim formula: 1 - cos(t) = 2sin²(t/2)

√[2·2sin²(t/2)] = 2|sin(t/2)| = 2sin(t/2) pentru t ∈ [0,2π]

L = ∫₀^(2π) 2sin(t/2) dt

Substituim u = t/2, du = dt/2:

L = 4∫₀^π sin(u) du = 4[-cos(u)]₀^π = 4(1+1) = 8

Raspuns: 8


Exercitiul 9.2 - Integrala curbilinie de tipul II

Cerinta: Sa se calculeze:
∫_C xy dx + dy
unde C: x = 9cos(t), y = 9sin(t), t ∈ [0, 2π]

Rezolvare:
Calculam dx si dy:
dx = -9sin(t) dt
dy = 9cos(t) dt

Inlocuim in integrala:
I = ∫₀^(2π) [81cos(t)sin(t)·(-9sin(t)) + 9cos(t)] dt

= ∫₀^(2π) [-729cos(t)sin²(t) + 9cos(t)] dt

= ∫₀^(2π) cos(t)[-729sin²(t) + 9] dt

Calculam:
∫ cos(t)·sin²(t) dt = sin³(t)/3

I = [-729·sin³(t)/3 + 9sin(t)]₀^(2π)

= [-243sin³(2π) + 9sin(2π)] - [-243sin³(0) + 9sin(0)]

= 0 - 0 = 0

Raspuns: 0


Exercitiul 9.3 - Independenta de drum

Cerinta: Sa se verifice daca integrala:
∫_C (2x+y)dx + (x+2y)dy
nu depinde de drum.

Rezolvare:
Pentru ca integrala sa nu depinda de drum,
expresia P dx + Q dy trebuie sa fie diferentiala exacta.

Conditie necesara si suficienta:
∂P/∂y = ∂Q/∂x

Avem:
P(x,y) = 2x + y  →  ∂P/∂y = 1
Q(x,y) = x + 2y  →  ∂Q/∂x = 1

Cum ∂P/∂y = ∂Q/∂x = 1, integrala nu depinde de drum.

Gasim functia potentiala f:
∂f/∂x = 2x + y  →  f = x² + xy + g(y)

∂f/∂y = x + g'(y) = x + 2y  →  g'(y) = 2y  →  g(y) = y²

Deci: f(x,y) = x² + xy + y² + C

Pentru orice curba de la A(x₁,y₁) la B(x₂,y₂):
∫_C = f(B) - f(A) = (x₂² + x₂y₂ + y₂²) - (x₁² + x₁y₁ + y₁²)


Exercitiul 9.4 - Formula Green

Cerinta: Sa se verifice formula Green pentru:
∫_C x²y dx + xy² dy
unde C este frontiera patratului [0,1] × [0,1] parcurs trigonometric.

Rezolvare:
Formula Green:
∫_C P dx + Q dy = ∬_D (∂Q/∂x - ∂P/∂y) dxdy

Avem:
P(x,y) = x²y  →  ∂P/∂y = x²
Q(x,y) = xy²  →  ∂Q/∂x = y²

∂Q/∂x - ∂P/∂y = y² - x²

Partea dreapta:
∬_D (y² - x²) dxdy = ∫₀^1 (∫₀^1 (y² - x²) dx) dy

= ∫₀^1 [x·y² - x³/3]₀^1 dy

= ∫₀^1 (y² - 1/3) dy

= [y³/3 - y/3]₀^1

= 1/3 - 1/3 = 0

Verificam partea stanga (calculand pe cele 4 laturi):
Latura 1 (y=0, x:0→1): ∫ 0 dx = 0
Latura 2 (x=1, y:0→1): ∫₀^1 y² dy = 1/3
Latura 3 (y=1, x:1→0): ∫₁^0 x² dx = -1/3
Latura 4 (x=0, y:1→0): ∫ 0 dy = 0

Total: 0 + 1/3 - 1/3 + 0 = 0 ✓

Formula Green este verificata.


===============================================
FORMULE ESENTIALE
===============================================

DERIVATE FUNDAMENTALE:

(x^n)' = n·x^(n-1)
(e^x)' = e^x
(ln x)' = 1/x
(sin x)' = cos x
(cos x)' = -sin x
(tg x)' = 1/cos²x
(ctg x)' = -1/sin²x
(arcsin x)' = 1/√(1-x²)
(arccos x)' = -1/√(1-x²)
(arctg x)' = 1/(1+x²)
(arcctg x)' = -1/(1+x²)


INTEGRALE FUNDAMENTALE:

∫ x^n dx = x^(n+1)/(n+1) + C,  n ≠ -1
∫ 1/x dx = ln|x| + C
∫ e^x dx = e^x + C
∫ sin x dx = -cos x + C
∫ cos x dx = sin x + C
∫ 1/cos²x dx = tg x + C
∫ 1/sin²x dx = -ctg x + C
∫ 1/(1+x²) dx = arctg x + C
∫ 1/√(1-x²) dx = arcsin x + C


DEZVOLTARI IN SERIE:

e^x = Σ x^n/n! = 1 + x + x²/2! + x³/3! + ...
     n=0

sin x = Σ (-1)^n · x^(2n+1)/(2n+1)! = x - x³/3! + x⁵/5! - ...
       n=0

cos x = Σ (-1)^n · x^(2n)/(2n)! = 1 - x²/2! + x⁴/4! - ...
       n=0

ln(1+x) = Σ (-1)^(n+1) · x^n/n = x - x²/2 + x³/3 - ..., |x| < 1
         n=1


CRITERII DE CONVERGENTA SERII:

1. Criteriul raportului: lim |a_(n+1)/a_n| < 1 → convergenta
                         n→∞

2. Criteriul radacinii: lim ⁿ√|a_n| < 1 → convergenta
                        n→∞

3. Criteriul Leibniz: pentru serii alternate Σ(-1)^n·u_n
   - u_n > 0
   - (u_n) descrescator
   - lim u_n = 0
   → seria convergenta


EXTREME (functii de 2 variabile):

Punct critic (x₀,y₀): f_x = 0, f_y = 0

Matricea Hessiana: H = |f_xx  f_xy|
                       |f_yx  f_yy|

det(H) > 0, f_xx > 0 → minim
det(H) > 0, f_xx < 0 → maxim
det(H) < 0 → punct de sa


COORDONATE POLARE:

x = r·cos(θ)
y = r·sin(θ)
dxdy = r dr dθ


COORDONATE SFERICE:

x = r·sin(φ)·cos(θ)
y = r·sin(φ)·sin(θ)
z = r·cos(φ)
dxdydz = r²·sin(φ) dr dφ dθ


===============================================
SFATURI PENTRU EXAMEN
===============================================

1. La serii: memoreaza criteriile si aplica-le in ordine
   (raport → radacina → comparatie)

2. La derivate partiale: verifica mereu daca f_xy = f_yx
   (criteriul Schwarz)

3. La extreme: nu uita sa verifici natura punctului cu Hessiana

4. La integrale duble: verifica daca coordonatele polare
   simplifica problema (cand apare x² + y²)

5. La integrale curbilinii: verifica intai daca nu depinde de drum
   (∂P/∂y = ∂Q/∂x)

6. La integrale improprii: verifica convergenta inainte de calcul

7. Scrie clar calculele - nu sari pasi importanti

8. Verifica raspunsul final - are sens fizic/matematic?


===============================================
FIN - MULT SUCCES LA EXAMEN!
===============================================