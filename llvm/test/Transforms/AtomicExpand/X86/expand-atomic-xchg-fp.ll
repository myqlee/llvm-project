; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=i686-linux-gnu -atomic-expand %s | FileCheck %s

define double @atomic_xchg_f64(double* %ptr) nounwind {
; CHECK-LABEL: @atomic_xchg_f64(
; CHECK-NEXT:    [[TMP1:%.*]] = load double, double* [[PTR:%.*]], align 8
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi double [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double* [[PTR]] to i64*
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double [[LOADED]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg i64* [[TMP2]], i64 [[TMP3]], i64 4616189618054758400 seq_cst seq_cst
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i64, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i64, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i64 [[NEWLOADED]] to double
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret double [[TMP5]]
;
  %result = atomicrmw xchg double* %ptr, double 4.0 seq_cst
  ret double %result
}

define double @atomic_xchg_f64_as1(double addrspace(1)* %ptr) nounwind {
; CHECK-LABEL: @atomic_xchg_f64_as1(
; CHECK-NEXT:    [[TMP1:%.*]] = load double, double addrspace(1)* [[PTR:%.*]], align 8
; CHECK-NEXT:    br label [[ATOMICRMW_START:%.*]]
; CHECK:       atomicrmw.start:
; CHECK-NEXT:    [[LOADED:%.*]] = phi double [ [[TMP1]], [[TMP0:%.*]] ], [ [[TMP5:%.*]], [[ATOMICRMW_START]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double addrspace(1)* [[PTR]] to i64 addrspace(1)*
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast double [[LOADED]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = cmpxchg i64 addrspace(1)* [[TMP2]], i64 [[TMP3]], i64 4616189618054758400 seq_cst seq_cst
; CHECK-NEXT:    [[SUCCESS:%.*]] = extractvalue { i64, i1 } [[TMP4]], 1
; CHECK-NEXT:    [[NEWLOADED:%.*]] = extractvalue { i64, i1 } [[TMP4]], 0
; CHECK-NEXT:    [[TMP5]] = bitcast i64 [[NEWLOADED]] to double
; CHECK-NEXT:    br i1 [[SUCCESS]], label [[ATOMICRMW_END:%.*]], label [[ATOMICRMW_START]]
; CHECK:       atomicrmw.end:
; CHECK-NEXT:    ret double [[TMP5]]
;
  %result = atomicrmw xchg double addrspace(1)* %ptr, double 4.0 seq_cst
  ret double %result
}
