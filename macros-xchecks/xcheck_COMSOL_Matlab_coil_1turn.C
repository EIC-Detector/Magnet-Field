xcheck_COMSOL_Matlab_coil_1turn()
{
  gStyle->SetOptStat(0);

  TTree *t_comsol = new TTree();
  t_comsol->ReadFile("COMSOL_BaBarCoil/SingleTurn_1000A_B_vs_Z_R0_RootFormat.txt","p0/F:p1:z:r:Br:Bphi:Bz");
  t_comsol->Draw("Bz*1000.:z/1000.");
  TGraph *g_comsol = new TGraph( t_comsol->GetEntries(), t_comsol->GetV2(), t_comsol->GetV1() );
  g_comsol->SetLineColor(kBlue);

  TTree *t_matlab = new TTree();
  t_matlab->ReadFile("Matlab/output/BField_singleTurn_a1.5m_I1000.0A.txt","");
  t_matlab->Draw("Bz:z");
  TGraph *g_matlab = new TGraph( t_matlab->GetEntries(), t_matlab->GetV2(), t_matlab->GetV1() );
  g_matlab->SetLineColor(kGreen+1);

  /* Legend */
  leg = new TLegend(0.6,0.8,0.9,0.9);
  leg->AddEntry(g_matlab,"Matlab (analytical)","l");
  leg->AddEntry(g_comsol,"COMSOL (FEM)","l");


  /* Draw comparison */
  TH1F* hframe = new TH1F("hframe","",100,-6,6);
  hframe->SetLineColor(0);
  hframe->GetYaxis()->SetRangeUser(0,0.45);
  hframe->GetXaxis()->SetTitle("z [m]");
  hframe->GetYaxis()->SetTitle("B_{z} [mT]");

  TCanvas *c1 = new TCanvas();
  hframe->Draw();
  leg->Draw();
  g_matlab->Draw("Lsame");
  g_comsol->Draw("Lsame");

  gPad->RedrawAxis();
  c1->Print("xcheck_1turn.png");
  c1->Print("xcheck_1turn.eps");
}
