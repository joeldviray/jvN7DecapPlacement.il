/* jvN7DecapPlacement.il
 *
 *
 * Author       Joel Viray
 * Language     SKILL
 * Date         Nov 19, 2018
 *
 * Auto replace decap type based on metals on top of it. 
 *
 *  
 */


procedure(abGetOverlapShape(overlap)
  if(listp(overlap) then
      abGetOverlapShape(cadr(overlap))
  else
      overlap
  );if
);procedure


procedure( jvN7DecapPlacement_change()

    cv=geGetEditCellView()

    foreach(decap geGetSelSet()

        pass=0

        decapbbox=decap~>bBox

        x1bbox=xCoord(lowerLeft(decapbbox))
		y1bbox=yCoord(lowerLeft(decapbbox))
        x2bbox=xCoord(upperRight(decapbbox))
		y2bbox=yCoord(upperRight(decapbbox))

        reduced_decapbbox=list(x1bbox+0.15:y1bbox+0.6 x2bbox-0.15:y2bbox-0.6)

        
        
        m1_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M1" "drawing"))
        m2_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M2" "drawing"))
        m3_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M3" "drawing"))
        m4_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M4" "drawing"))
        m5_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M5" "drawing"))
        m6_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M6" "drawing"))
        m7_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M7" "drawing"))
        m8_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M8" "drawing"))
        m9_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("M9" "drawing"))

            
        
        if(m2_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M1" "layout") pass=1)
            if(m3_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M2" "layout") pass=1)
                if(m4_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M3" "layout") pass=1)
                    if(m5_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M4" "layout") pass=1)
                        if(m6_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M5" "layout") pass=1)
                            if(m7_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M6" "layout") pass=1)
                                if(m8_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M7" "layout") pass=1)
                                    if(m9_overlaps!=nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M8" "layout") pass=1)
                                        if(m9_overlaps==nil&&pass==0 then decap~>master=dbOpenCellViewByType("inphi_n7_common" "decap_0p9v_pm_ulvt_86n_M9" "layout"))
 
                  
        

    );foreach


);procedure


procedure(jvN7DecapPlacement_remove()


    foreach(decap geGetSelSet()

        decapbbox=decap~>bBox

        x1bbox=xCoord(lowerLeft(decapbbox))
		y1bbox=yCoord(lowerLeft(decapbbox))
        x2bbox=xCoord(upperRight(decapbbox))
		y2bbox=yCoord(upperRight(decapbbox))

        reduced_decapbbox=list(x1bbox+0.15:y1bbox+0.6 x2bbox-0.15:y2bbox-0.6)

        
        PO_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("PO" "drawing"))
        POd_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("PO" "dummy"))
        CMD_overlaps=dbProduceOverlap(cv reduced_decapbbox 32 list("CMD" "dummy"))



        flattened_PO_overlaps=foreach(mapcar overlap PO_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach

        flattened_POd_overlaps=foreach(mapcar overlap POd_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach

        flattened_CMD_overlaps=foreach(mapcar overlap CMD_overlaps
                              srcShape=abGetOverlapShape(overlap)
                              ;dbCopyFig(srcShape cv dbGetHierPathTransform(overlap))
                              );foreach



        if(length(flattened_PO_overlaps)>1806||length(flattened_POd_overlaps)>1||length(flattened_CMD_overlaps)>1
            then
            dbDeleteObject(decap)
        );if
      
               
    );foreach

);procedure


procedure(jvN7DecapPlacement()

    jvN7DecapPlacement_remove()
    jvN7DecapPlacement_change()

);procedure


