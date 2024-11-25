final String warningPools =
    "WARNING: Swimming Pool to be kept empty during navigation. Use of swimming pool is falling under Master responsibility";

final String notePools =
    "NOTE:Swimming pool water is deducted from (in case of loading) or addedd to (in case of discharge) ${options.map((tank) => tank)}. No outbord discharge is envisaged in the calculation.";

final List<String> options = [
  'F.W. 14',
  'F.W. 21',
  'F.W. 23',
  'P.T. 25'
]; // Lista dinamica