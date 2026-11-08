'use strict';
const menuButton=document.getElementById('menu-toggle');
const mobileNav=document.getElementById('main-nav');
if(menuButton && mobileNav){menuButton.addEventListener('click',()=>{
  const open=mobileNav.classList.toggle('open');menuButton.setAttribute('aria-expanded',String(open));
  menuButton.textContent=open?'×':'☰';
});}
document.querySelectorAll('[data-close]').forEach(b=>b.addEventListener('click',()=>b.closest('.alert').remove()));
document.querySelectorAll('[data-confirm]').forEach(f=>f.addEventListener('submit',e=>{
  if(!window.confirm(f.dataset.confirm))e.preventDefault();
}));
const modal=document.getElementById('edit-modal');
const editForm=document.getElementById('edit-form');
if(modal && editForm){
 const close=()=>{modal.classList.remove('show');modal.setAttribute('aria-hidden','true');};
 const open=()=>{modal.classList.add('show');modal.setAttribute('aria-hidden','false');};
 document.querySelectorAll('[data-edit]').forEach(b=>b.addEventListener('click',()=>{
   editForm.action='/manage/'+encodeURIComponent(b.dataset.event)+'/'+encodeURIComponent(b.dataset.occ)+'/edit';
   document.getElementById('edit-event').value=b.dataset.event;
   document.getElementById('edit-start').value=b.dataset.start;
   document.getElementById('edit-end').value=b.dataset.end;
   document.getElementById('edit-factor').value=b.dataset.factor;
   document.getElementById('edit-venue').value=b.dataset.venue;
   document.getElementById('edit-note').value=b.dataset.note;
   open();document.getElementById('edit-start').focus();
 }));
 modal.querySelectorAll('[data-modal-close]').forEach(b=>b.addEventListener('click',close));
 modal.addEventListener('click',e=>{if(e.target===modal)close();});
 document.addEventListener('keydown',e=>{if(e.key==='Escape')close();});
}
