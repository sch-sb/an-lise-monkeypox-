# analise-monkeypox-

Script criado para automatizar os cálculos do perfil epidemiológico dos casos de monkeypox, extraídos da planilha da vigilãncia do Distrito Federal.

Foi estabelecido pelo COE de Monkeypox que um boletim seria lançado todas as quintas, informando a quantidade de casos por gênero, RA, status, etc. Para auxiliar na reunião dessas informações, criei um script de R cuja finalidade é:
- Importar o banco de dados da planilha interna de monkeypox
- Filtrar os casos “em investigação” e “indeterminado” como um objeto chamado “suspeitos”; os casos “descartados” como objeto “descartado” e os casos “confirmado” e “provável” como objeto “confirmados”
- Dentro dos confirmados, agrupar por faixa etária e gerar um output da quantidade de cada um
- Dentro dos confirmados, agrupar por sexo e gerar um output da quantidade de cada
- Dentro dos confirmados, agrupar por RA de residência e gerar um output da quantidade
- Dentro dos suspeitos e confirmados, agrupar por data de início de sintomas e gerar um output da quantidade
- Então reunir cada quantidade dessas em um “sheet” de planilha do excel e me devolver uma planilha com tabelas com a quantidade de cada, para automatizar a fabricação dos cards

