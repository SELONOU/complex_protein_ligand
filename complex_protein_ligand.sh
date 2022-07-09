while IFS=" " read -r name;
do 
	obabel "$name".pdbqt -O  ob_"$name".pdb
	obabel ob_"$name".pdb -O  ob_"$name"_H.pdb -h
	grep "ATOM  " ob_"$name"_H.pdb > ob2_"$name".pdb
	sed -i 's/ATOM  /HETATM/g' ob2_"$name".pdb   # sed -i 's/old-text/new-text/g' input.tx
	grep "ATOM " receptor.pdb > receptor_b.pdb
	cat receptor_b.pdb ob2_"$name".pdb > complex_"$name".pdb
done < list_all.txt
